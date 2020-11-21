# Import Dependencies -------------------------------------------------------------------------------------------------------

# ...

# Initialise Twitter Token --------------------------------------------------------------------------------------------------

twitter_token <- create_token(
  app = '',
  consumer_key = '',
  consumer_secret = ''
)

# Acquire Data --------------------------------------------------------------------------------------------------------------

tweets_filename <- './tweets.csv'
users_filename <- './users.csv'

query <- '#3DPrinting -filter:quote -filter:replies'

# If the data already exists locally, import it
if (file.exists(tweets_filename) && file.exists(users_filename)) {
  tweets <- read_csv(tweets_filename)
  users <- read_csv(users_filename)
} else {
  tweets <- search_tweets(query, n = 5000, token = twitter_token)
  users <- users_data(tweets)
}

# Data Cleaning -------------------------------------------------------------------------------------------------------------

# Remove columns from the tweet data
cols_to_keep <- c('user_id', 'status_id', 'created_at', 'screen_name', 'text', 'source', 'is_retweet', 'favorite_count',
                  'retweet_count','hashtags', 'media_type', 'lang')
tweets <- tweets[cols_to_keep]

# Remove columns from the user data
cols_to_keep <- c('user_id', 'screen_name', 'name', 'location', 'description', 'followers_count', 'friends_count',
                  'statuses_count', 'favourites_count', 'account_created_at', 'verified')
users <- users[cols_to_keep]

# Remove duplicate rows from the users data; we only need one entry per user
users <- distinct(users, user_id, .keep_all = TRUE)

# Convert blank location values to NA
users$location[users$location == ''] <- NA

# Convert columns of type 'list' to 'char'
convert_lists_to_chars <- function(column) {
  if (class(column) == 'list') {
    new_column <- paste(unlist(column[1]), sep = '', collapse = ', ')
  } else {
    new_column <- column
  }
  
  return(new_column)
}
tweets <- data.frame(lapply(tweets, convert_lists_to_chars), stringsAsFactors = F)
users <- data.frame(lapply(users, convert_lists_to_chars), stringsAsFactors = F)

# Export Data ---------------------------------------------------------------------------------------------------------------
write.csv(tweets, tweets_filename)
write.csv(users, users_filename)
