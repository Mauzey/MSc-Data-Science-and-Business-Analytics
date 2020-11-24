# Q1: Classes in Python

# Import and Setup
import pandas as pd


class Football:
    def load(self, path):
        """ Loads a .csv file into dataframe

        :param path: (str) The path to the .csv file to be loaded
        """
        self.df = pd.read_csv(path)
        print("Loaded data from {}".format(path))

    def count_male_teams(self):
        """ Returns the number of male football teams in the data

        :return: (int) Number of male football teams
        """
        return len(self.df['Adult male 11v11 (16-45)'].dropna())

fb_plym = Football()
fb_plym.load('data-showing-sports-use-of-football-pitches.csv')
mteam_count = fb_plym.count_male_teams()

print("Number of male football teams in Plymouth: {}".format(mteam_count))


# filename = 'data-showing-sports-use-of-football-pitches.csv'
# df = pd.read_csv(filename)
#
# male_teams = df['Adult male 11v11 (16-45)']
# male_teams = male_teams.dropna()
#
# mteam_count = len(male_teams)
# print("Number of male football teams in Plymouth: {}".format(mteam_count))