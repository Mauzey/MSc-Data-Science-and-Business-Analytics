# Import and Setup ------------------------------------
library(rtweet)
library(readr)
library(ggplot2)
library(dplyr)

twitter_token <- create_token(
  app = "math513-social-media-analysis",
  consumer_key = Sys.getenv("TWITTER_TOKEN"),
  consumer_secret = Sys.getenv("TWITTER_SECRET"))

# Acquire Data ----------------------------------------
# search and download tweets, then save to .csv
tweets <- search_tweets("#3dprinting",
                        n = 5000,
                        token = twitter_token)

write.csv(tweets, 'Session-6/3dprinting_tweets.csv')

# alternatively, read an existing .csv
tweets <- read_csv('Session-6/3dprinting_tweets.csv')


# preview users data, which is a subset of the information
#   retrieved using 'search_tweets()'
users <- users_data(tweets)

# Time Series Data ------------------------------------
ts_plot(tweets, "hours")
ts_plot(tweets, "hours") +
  theme_minimal() +
  theme(plot.title = element_text(face = "bold")) +
  labs(x = NULL, y = NULL,
       title = "Frequency of #3DPrinting Twitter Statuses",
       subtitle = "Status Counts Aggregated by 1-Hour Intervals",
       caption = "Source: Data collected from Twitter's REST API via rtweet"
  )
