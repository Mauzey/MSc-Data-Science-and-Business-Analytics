# import
import calendar

def main():
    # create a plain text calendar
    c = calendar.TextCalendar(calendar.SUNDAY)
    st = c.formatmonth(2020, 1, 0, 0)
    print(st)
    
    # create an HTML formatted calendar
    hc= calendar.HTMLCalendar(calendar.SUNDAY)
    st = hc.formatmonth(2020, 1)
    print(st)
    
    # loop over days of a month
    # zeroes mean that the day of the week is in an overlapping month
    for day in c.itermonthdays(2020, 8):
        print(day)
    
    # the calendar module provides useful utilities for the given locale,
    #   such as the names of days and months in both full and abbreviated forms
    for month in calendar.month_name:
        print(month)
    
    for day in calendar.day_name:
        print(day)
    
    # calculate days based on a rule: for example, consider a team meeting on the
    #   first friday of every month. To figure out what days that would be for
    #   each month, we can use this script:
    print("Team meetings will be on: ")
    
    for month in range(1,13):
        cal = calendar.monthcalendar(2020, month)
        week_one = cal[0]
        week_two = cal[1]
        
        # determine which week contains the first friday of the month
        if week_one[calendar.FRIDAY] != 0:
            meet_day = week_one[calendar.FRIDAY]
        else:
            meet_day = week_two[calendar.FRIDAY]
        
        print("%10s %2d" % (calendar.month_name[month], meet_day))

if __name__ == '__main__':
    main()