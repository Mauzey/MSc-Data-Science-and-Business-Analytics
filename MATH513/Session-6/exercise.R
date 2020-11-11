
# Import and Setup --------------------------------------------------------
library(rtweet)
library(readr)
library(ggplot2)
library(dplyr)
library(tidytext)
library(wordcloud)
library(wordcloud2)

twitter_token <- create_token(
  app = "math513-social-media-analysis",
  consumer_key = Sys.getenv("TWITTER_TOKEN"),
  consumer_secret = Sys.getenv("TWITTER_SECRET"))

# Acquire Data ------------------------------------------------------------
tweets_filename <- 'Session-6/3dprinting-tweets.csv'
users_filename <- 'Session-6/3dprinting-users.csv'

# The query to use when collecting tweets: excludes quotes and replies
query <- '#3DPrinting -filter:quote -filter:replies'

# If there are files already containing relevant data, import them
if (file.exists(tweets_filename) && file.exists(users_filename)){
  tweets <- read_csv(tweets_filename)
  users <- read_csv(users_filename)
# Otherwise, gather new data
} else {
  tweets <- search_tweets(query, n = 5000, token = twitter_token)
  users <- users_data(tweets)
}

# Examine the structure of the collected data
dim(tweets)
names(tweets)
dim(users)
names(users)

# Data Cleaning -----------------------------------------------------------
# Remove columns from the tweets data
cols_to_keep <- c('user_id', 'status_id', 'created_at', 'screen_name', 'text',
                  'source', 'is_retweet', 'favorite_count', 'retweet_count',
                  'hashtags', 'media_type', 'lang')
tweets <- tweets[cols_to_keep]

# Remove columns from the users data
cols_to_keep <- c('user_id', 'screen_name', 'name', 'location', 'description',
                  'followers_count', 'friends_count', 'statuses_count',
                  'favourites_count', 'account_created_at', 'verified')
users <- users[cols_to_keep]

# Remove duplicate rows from the users data; we only need one entry per user
users <- distinct(users, user_id, .keep_all = TRUE)

# Convert blank location values to NA
users$location[users$location == ''] <- NA

# Convert columns of type 'list' to 'char'
convert_lists_to_chars <- function(x) {
  if (class(x) == 'list') {
    y <- paste(unlist(x[1]), sep = '', collapse = ', ')
  } else {
    y <- x
  }
  
  return(y)
}
tweets <- data.frame(lapply(tweets, convert_lists_to_chars), stringsAsFactors = F)

# Exporting Data ----------------------------------------------------------
write.csv(tweets, 'Session-6/3dprinting-tweets.csv')
write.csv(users, 'Session-6/3dprinting-users.csv')

# Plotting Time Series Data -----------------------------------------------
ts_plot(tweets, 'hours') +
  theme_minimal() +
  theme(plot.title = element_text(face = 'bold')) +
  labs(x = NULL, y = NULL,
       title = "Frequency of '#3DPrinting' Twitter Statuses Over Time",
       subtitle = "Status counts aggregated by 1-hour intervals",
       caption = "Source: Data collected from Twitter's REST API via rtweet")

# Plotting Tweets vs. Re-Tweets -------------------------------------------
tweets %>%
  group_by(is_retweet) %>%
  ts_plot('hours', lwd = 1) +
    theme_minimal() +
    theme(plot.title = element_text(face = 'bold')) +
    labs(x = NULL, y = NULL,
         title = "Frequency of '#3DPrinting' Twitter Statuses Over Time",
         subtitle = "Status counts aggregated by 1-hour intervals",
         caption = "Source: Data collected from Twitter's REST API via rtweet",
         colour = "Retweet")

# Plotting User Location Frequency ----------------------------------------
# Combine similar locations
users <- users %>%
  mutate(location_rec = recode(location,
                               'Paris, France' = 'France',
                               'Earth' = 'Worldwide', 'Global' = 'Worldwide',
                               'International' = 'Worldwide',
                               'Europe' = 'Worldwide',
                               'UK' = 'United Kingdom',
                               'London' = 'United Kingdom',
                               'London, UK' = 'United Kingdom',
                               'London, England' = 'United Kingdom',
                               'Bengaluru, India' = 'India',
                               'England, United Kingdom' = 'United Kingdom',
                               'Hyderabad, India' = 'India',
                               'Pune, India' = 'India',
                               'San Francisco, CA' = 'United States',
                               'Seattle, WA' = 'United States'))

users %>%
  count(location_rec, sort = TRUE) %>% # Count the frequency of each location
  mutate(location_rec = reorder(location_rec, n)) %>% # Order locations by frequency
  na.omit() %>% # Remove NA values
  head(5) %>% # Select the top locations
  ggplot(aes(x = location_rec, y = n)) +
    geom_col(fill = 'cyan') + coord_flip() +
    theme_minimal() +
    theme(plot.title = element_text(face = 'bold')) +
    labs(x = NULL, y = NULL,
         title = "Top 5 Locations of Users Posting '#3DPrinting' Tweets",
         caption = "Source: Data collected from Twitter's REST API via rtweet")

# Plotting Devices Used to Tweet ------------------------------------------
tweets %>%
  group_by(source) %>%
  summarise(Total = n()) %>%
  arrange(desc(Total)) %>%
  head(5) %>%
  ggplot(aes(reorder(source, Total), Total, fill = source)) +
    geom_col(fill = 'cyan') + coord_flip() +
    theme_minimal() +
    theme(plot.title = element_text(face = 'bold')) +
    labs(x = NULL, y = NULL,
         title = "Top 5 Sources of '#3DPrinting' Tweets",
         caption = "Source: Data collected from Twitter's REST API via rtweet")

# Plotting User Information -----------------------------------------------
users %>%
  group_by(screen_name) %>%
  arrange(desc(followers_count)) %>%
  head(10) %>%
  ggplot(aes(reorder(screen_name, followers_count), followers_count, fill = name)) +
    geom_col() + coord_flip() +
    theme_minimal() +
    theme(plot.title = element_text(face = 'bold'), legend.position = 'none') +
    labs(x = NULL, y = 'Follower Count',
         title = "Top Twitter Users Posting about '#3DPrinting'",
         caption = "Source: Data collected from Twitter's REST API via rtweet")


# Word Frequencies --------------------------------------------------------
# Remove http elements
tweets$stripped_text <- gsub('http.*', '', tweets$text)
tweets$stripped_text <- gsub('https.*', '', tweets$stripped_text)
tweets$stripped_text <- gsub('amp', '', tweets$stripped_text)

# Remove punctuation, convert to lowercase, and add an id for each tweet
tweets_clean <- tweets %>%
  select(stripped_text) %>%
  mutate(tweetnumber = row_number()) %>%
  unnest_tokens(word, stripped_text)

# Load a list of stop words, and remove them from the list of words
data("stop_words")
cleaned_tweet_words <- tweets_clean %>%
  anti_join(stop_words)

# Create a custom list of stop words, and remove them from the list of words
custom_stop_words <- data.frame(word = c('3dprinting', '3d', 'printing',
                                         'printed', 'printer', 'print',
                                         '3dprint', '3dprinted'))
cleaned_tweet_words <- cleaned_tweet_words %>%
  anti_join(custom_stop_words)

cleaned_tweet_words %>%
  # Count the number of occurrences of each word, and sort by that count
  count(word, sort = TRUE) %>%
  head(10) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(x = word, y = n)) +
    geom_col() + coord_flip() +
    theme_minimal() +
    theme(plot.title = element_text(face = 'bold')) +
    labs(x = "Unique Words", y = "Frequency",
         title = "Count of Unique Words in '#3DPrinting' Tweets",
         caption = "Source: Data collected from Twitter's REST API via rtweet")

# Word Cloud --------------------------------------------------------------
# Calculate the count of each word, and sort the words according to that count, 
#   before calculating the frequency of each word, as defined by:
#   count of each word / total count
cleaned_tweet_words <- cleaned_tweet_words %>%
  count(word, sort = TRUE) %>%
  mutate(freq = n / sum(n))

# Create the word cloud
with(cleaned_tweet_words, wordcloud(word, freq,
                                    min.freq = 1,
                                    max.words = 50,
                                    random.order = F,
                                    colors = brewer.pal(8, 'PuRd'),
                                    scale = c(4.5, 0.1)))
# Add a title to the word cloud
title(main = "Word Cloud for Tweets Containing the Hashtag '#3DPrinting'",
      cex.main = 1)

# Create an alternative word cloud. Note that this appears in the viewer, so it
#   isn't an ordinary plot
cleaned_tweet_words %>% select(word, freq) %>%
  wordcloud2()