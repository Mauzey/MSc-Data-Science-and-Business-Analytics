# import
import urllib.request
import json

def printResults(data):
    # use the json module to load the string data into a dictionary
    json_data = json.loads(data)
    
    # now we can accessthe contents of the json like any other python object
    if "title" in json_data["metadata"]:
        print(json_data["metadata"]["title"])
    
    # output the number of events, plus the magnitude and each event name
    count = json_data["metadata"]["count"]
    print(str(count) + " events recorded\n")
    
    # for each event, print the place where it occurred
    for i in json_data["features"]:
        print(i["properties"]["place"])
    print("\n")
    
    # print the events that only have a magnitude greater than 4
    for i in json_data["features"]:
        if i["properties"]["mag"] >= 4.0:
            print("%2.1f" % i["properties"]["mag"], i["properties"]["place"])
    print("\n")
    
    # print only the events where at least 1 person reported feeling something
    print("Events that were felt:")
    for i in json_data["features"]:
        felt_reports = i["properties"]["felt"]
        if felt_reports != None and felt_reports > 0:
            print("%2.1f" % i["properties"]["mag"], i["properties"]["place"],
                  " reported " + str(felt_reports) + " times")

def main():
    # define a variable to hold the source url
    #   In this case, we'll use the free data feed from the USGS
    #   This feed lists all earthquakes for the last day larger than Mag 2.5
    url_data = "http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/2.5_day.geojson"
    
    # open the url and read the data
    web_url = urllib.request.urlopen(url_data)
    print("Result code: " + str(web_url.getcode()))
    
    if (web_url.getcode() == 200):
        data = web_url.read()
        printResults(data)
    else:
        print("Received error, cannot parse results")

if __name__ == '__main__':
    main()