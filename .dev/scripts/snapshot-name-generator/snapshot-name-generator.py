import datetime

current_year = datetime.date.today().year
current_year_week = datetime.date.today().isocalendar()[1]
alphabet = "abcdefghijklmnopqrstuvwxyz"

def get_snapshot():
    return str(current_year) + 'w' + str(current_year_week)+alphabet[int(input("How many snapshots have there been this week?\n> "))]

print("Snapshot "+ str(get_snapshot()))