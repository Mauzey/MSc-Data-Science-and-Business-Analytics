""" tweet-processor.py
|
|   DESCRIPTION HERE ...
"""
# Import libraries
import argparse
import json
import os
import pandas as pd

# Construct argument parser and parse arguments
parser = argparse.ArgumentParser(description="""
    Takes a collection of replies to a certain tweet (as JSON objects). The information about each reply is exported as 
    a CSV file. Additionally, user information is extracted and stored in a separate CSV file.
""")
parser.add_argument('data', type=str, help="""
    JSON data which is processed. This data can be obtained from: https://inkdroid.org/2017/01/29/replies/
""")
args = parser.parse_args()

"""
|
|   EXTRACT REPLIES, STORE IN DATAFRAME, PROCESS DATAFRAME
|
"""
# Extract tweet replies from the provided JSON file, and store as a DataFrame
tweets = []
with open(args.data) as file:
    for line in file:
        tweets.append(json.loads(line))
replies_df = pd.DataFrame(tweets)

# Drop unnecessary columns from the replies DataFrame
cols_to_drop = ['id_str', 'truncated', 'display_text_range', 'in_reply_to_status_id', 'in_reply_to_status_id_str',
                'in_reply_to_user_id', 'in_reply_to_user_id_str', 'geo', 'coordinates', 'place', 'contributors',
                'is_quote_status', 'favorited', 'retweeted', 'possibly_sensitive', 'metadata']
replies_df = replies_df.drop(columns=cols_to_drop)
replies_df = replies_df.drop(0)  # Drop the first row as it is the original tweet, not a reply

# Format the 'created_at' column from a string object to datetime64 object
replies_df['created_at'] = pd.to_datetime(replies_df['created_at'])

# Remove the handle of the user being replied to from the reply text
replies_df['full_text'] = replies_df.apply(lambda row: row['full_text'].replace(
    '@' + row['in_reply_to_screen_name'], ''), axis=1)

# Remove links from the tweet text
# ...

"""
|
|   EXTRACT USER DATA, STORE IN SEPARATE DATAFRAME, PROCESS DATAFRAME
|
"""
# Extract the user id of the tweet author, and add is as 'user_id' to the replies dataframe
replies_df['user_id'] = replies_df.apply(lambda row: row['user']['id'], axis=1)

# Extract user information from the replies dataframe, and store as a separate 'users' dataframe
users = []
replies_df.apply(lambda row: users.append(row['user']), axis=1)
users_df = pd.DataFrame(users)

replies_df = replies_df.drop(columns=['user'])

# Drop unnecessary columns from the users dataframe
cols_to_drop = ['id_str', 'url', 'entities', 'protected', 'listed_count', 'favourites_count', 'utc_offset', 'time_zone',
                'geo_enabled', 'lang', 'contributors_enabled', 'is_translator', 'is_translation_enabled',
                'profile_background_color', 'profile_background_image_url', 'profile_background_image_url_https',
                'profile_background_tile', 'profile_image_url', 'profile_image_url_https', 'profile_banner_url',
                'profile_link_color', 'profile_sidebar_border_color', 'profile_sidebar_fill_color',
                'profile_text_color', 'profile_use_background_image', 'has_extended_profile', 'default_profile',
                'default_profile_image', 'following', 'follow_request_sent', 'notifications', 'translator_type']
users_df = users_df.drop(columns=cols_to_drop)

# Format the 'created_at' column from a string object to datetime64 object
users_df['created_at'] = pd.to_datetime(replies_df['created_at'])

"""
|
|   EXPORT DATA AS CSV
|
"""


def export_csv(data, filename):
    """ Checks if a file exists. If a file is found, data is appended to that file. If no file is found, a new file is
    created.

    :param data: (dataframe) Dataframe to be exported
    :param filename: (str) Name of the exported file
    """
    if not os.path.exists(filename):
        print("[INFO] No pre-existing '{}' file found, exporting as new file...".format(filename))
        data.to_csv(filename)  # Export
    else:
        print("[INFO] Existing '{}' file found, appending to this file...".format(filename))
        existing_df = pd.read_csv(filename)  # Import existing data
        new_df = existing_df.merge(data, on='id', how='outer')  # Merge current data with existing data
        new_df.to_csv(filename)  # Export


# Export replies data
replies_filename = os.path.splitext(args.data)[0] + '-replies.csv'
export_csv(replies_df, replies_filename)

# Export users data
users_filename = os.path.splitext(args.data)[0] + '-users.csv'
export_csv(users_df, users_filename)
