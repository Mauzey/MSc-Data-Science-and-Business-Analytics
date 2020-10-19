#
###
### Practical 7: Working with Databases in R
###
#
#
## ------------------------------------------------------------------------
#
# Introduction to Databases
#
## ------------------------------------------------------------------------
#
# We are going to work with a real sqlite database called firms_db.sqlite3
#
# You should place this file in your working directory such as
#
# If you have RStudio installed on your machine or you are using the University 
# machines and your working directory is in your memory stick on the "D" drive:
setwd("D://MATH513")
#
## ------------------------------------------------------------------------
#
# Load the required packages
#
# dbplyr and dplyr provides us with many functions for dealing with databases
#
library(dbplyr) 
library(dplyr)
library(tidyr)
library(ggplot2)
library(RSQLite)
#
## ------------------------------------------------------------------------
#
# Connect to the firms_db.sqlite3 database
#
firms <- dbConnect(drv = SQLite(), dbname= "firms_db.sqlite3") 
firms
#
# Check which tables are inside the firms_db.sqlite3 database
#
dbListTables(firms)
#
## ------------------------------------------------------------------------
#
# Let's see what information we are provided with
#
# Information about Customers
#
tbl(firms, "Customers")
#
# Information about Orders
#
tbl(firms, "Orders")
#
# Details about Orders such as the quantity of each product contained in it
#
tbl(firms, "OrderDetails")
#
# Information about products
#
tbl(firms, "Products")
#
# We can see what sqlite query is being sent to the database
# SQL stands for Structured Query Language
#
q1 <- tbl(firms, "Customers")
q1 # The results
#
explain(q1)
#
# Other sqlite examples
#
# filter on rows
#
# List the products ordered with order Quantity more than 20 and (&) Discount of 15%
#
q2 <- tbl(firms, "OrderDetails") %>% filter(Quantity > 20 & Discount == "15%") 
q2
#
explain(q2)
#
# select columns
#
# List the products ordered and their quantity
#
q3 <- tbl(firms, "OrderDetails") %>% select(ProductID, Quantity)
q3
#
explain(q3)
#
# group summaries: the total quantity of each product
#
q4 <- tbl(firms, "OrderDetails") %>% group_by(ProductID) %>% 
  summarise(Total_Quantity = sum(Quantity))
q4
#
explain(q4)
#
#
## ------------------------------------------------------------------------
#
# We can translate R code into sql
#
translate_sql(x) # which yields a variable names escaped by single quotes
translate_sql("Hello") # which yields a strings escaped by single quotes
translate_sql(x == 1 & (y < 2 | z > 3))
#
translate_sql(mean(x))
translate_sql(sd(x))
#
# There are other examples in the SQL translation document 
# https://cran.r-project.org/web/packages/dbplyr/vignettes/translation-function.html
#
#
## ------------------------------------------------------------------------
#
# dplyr is lazy
#
# The following operation never touches the database
#
order_statistics <- tbl(firms, "OrderDetails") %>% 
  group_by(ProductID) %>% 
  summarise(Mean_Quantity = mean(Quantity), 
            SD_Quantity = sd(Quantity))
#
# It's not until you ask for the data (e.g. by printing order_statistic) 
# that dplyr generates the sqlite code
# and requests the results from the database, and even then it only pulls down 10 rows
#
order_statistics
#
# Note the ?? for the number of rows
#
# To pull down all the results use collect()
#
collect_local <- collect(order_statistics)
collect_local
#
## ------------------------------------------------------------------------
#
# Obtaining a random part of a table
#
# One way to proceed with very big data is to pull down randomly selected rows of a table
# We select the rows at random in the hope that they may be representative of the whole table
#
# Here is a quick example
#
OrderDetails <- tbl(firms, "OrderDetails")
OrderDetails
#
OrderDetails_local <- collect(OrderDetails)
OrderDetails_local # 1501 rows
#
# Select 100 of the rows in the OrderDetails table at random
#
OrderDetails_100 <- tbl(firms, sql("SELECT * FROM OrderDetails ORDER BY Random() LIMIT 100"))
OrderDetails_100
OrderDetails_100_local <- collect(OrderDetails_100)
OrderDetails_100_local
#
# Can be slow
#
# While we're at it, please note that there are dplyr functions that allow us to
# select a part of a *** local data frame ***
#
# Randomly sample 100 rows
#
OrderDetails_local %>% sample_n(100, replace = FALSE)
#
# Randomly sample a tenth of the database  
#
OrderDetails_local %>% sample_frac(0.1, replace = FALSE)
#
## ------------------------------------------------------------------------
#
# Further Operations on Database Tables
#
# Changing the names of variables using rename 
#
tbl(firms, "Customers")
#
tbl(firms, "Customers") %>% 
  rename(Person_ID = CustomerID) 
#
# Defining new variables using mutate
#
tbl(firms, "OrderDetails") %>% 
  mutate(Price_Quantity = Price * Quantity)
#
# Joining database tables
#
tbl(firms, "OrderDetails")
tbl(firms, "Products")
#
# We will inner_join these two tables
# Remember please that inner_join returns all rows from the first argument 
# where there are matching values in the second argument, and all columns
#
inner_join(tbl(firms, "OrderDetails"), 
           tbl(firms, "Products"), 
           by = "ProductID")
#
## ------------------------------------------------------------------------
#
# Some Additional Analysis
#
# Let's bring the joined OrderDetails and Products information to R
#
Orders_Products <- inner_join(tbl(firms, "OrderDetails"), 
                              tbl(firms, "Products"), 
                              by = "ProductID")
Orders_Products
Orders_Products_local <- collect(Orders_Products)
Orders_Products_local # Local data frame
#
# We can produce a histogram of order quantities
#
ggplot(Orders_Products_local, aes(x = Quantity.x)) + 
  geom_histogram() + 
  labs(x = "Order Quantity")
#
# split up by product
#
ggplot(Orders_Products_local, aes(x = Quantity.x)) + 
  geom_histogram() + 
  labs(x = "Order Quantity") + 
  facet_wrap(~ ProductID)
#
# To display the facets in numerical order, 
# we need to specify the levels of the factor ProductID
#
# Let's see the possible values
#
numerical_values <- as.numeric(Orders_Products_local$ProductID)
range(numerical_values)
#
# Now let's define a new factor ProductID_f with all these levels 
#
Orders_Products_local <- Orders_Products_local %>% 
  mutate(ProductID_f = factor(ProductID, 
                              levels = min(numerical_values):max(numerical_values)))
#
head(Orders_Products_local$ProductID_f)
#
# Replot
#
ggplot(Orders_Products_local, aes(x = Quantity.x)) + 
  geom_histogram() + 
  labs(x = "Order Quantity") + 
  facet_wrap(~ ProductID_f)
#
## ------------------------------------------------------------------------
#
# We can see the number of orders attended to by each supplier using a barplot
#
Orders_Products_local
#
# geom_bar from ggplot2 will do the counting for us
#
ggplot(Orders_Products_local, aes(x = SupplierID)) + 
  geom_bar()
#
# Again, we need to impose an ordering
#
# We can do this by performing the counting ourself and 
# arranging the results according to 
# the number of orders attended to by each supplier
#
Suppliers_ordered <- Orders_Products_local %>% 
  group_by(SupplierID) %>% 
  summarise(n = n()) %>% 
  arrange(desc(n))
#
Suppliers_ordered
#
# The bar plot plot
#
ggplot(Suppliers_ordered, aes(x = factor(SupplierID, levels = SupplierID), y = n)) + 
  geom_bar(stat = "identity") + # We use the n values themselves, without counting
  labs(x = "Supplier")
#
# This can also be done automatically on the original data frame
#
ggplot(Orders_Products_local, 
       aes(x = reorder(SupplierID, SupplierID, FUN = function(x){-length(x)}))) +
  # We reorder the words according to the number of times that they occur (the length of each word subset) in decreasing order (-)
  geom_bar() + 
  labs(x = "Supplier")

