# import
from datetime import timedelta
from datetime import datetime
from datetime import date
from datetime import time


def main():
    # construct a basic timedelta and print it
    print(timedelta(days=365, hours=5, minutes=1))
    
    # print today's date
    now = datetime.now()
    print("Today's date: " + str(now))
    
    # print today's date one year from now
    print("One year from now, it will be: " + str(now + timedelta(days=365)))
    
    # create a timedelta that uses more than one argument
    print("In 2 days and 3 weeks, it will be: " +
          str(now + timedelta(days=2, weeks=3)))
    
    # calculate the date one week ago, formatted as a string
    t = datetime.now() - timedelta(weeks=1)
    s = t.strftime("%A %B %d, %Y")
    print("One week ago, it was: " + s)
    
    # how many days until april fools' day?
    today = date.today()
    afd = date(today.year, 4, 1)
    
    # use date comparison to see if april fools' day has already happened this
    #   year. If it has, use the replace() function to get the date for next year
    if afd < today:
        print("April fools' day has already happened, %d days ago" % (today-afd).days)
        afd = afd.replace(year=today.year + 1)
    
    # now calculate the amount of time until april fools' day
    time_to_afd = afd - today
    print("It's just", time_to_afd.days, "days until april fools' day")


if __name__ == '__main__':
    main()
