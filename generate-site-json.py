import csv
import json
import os
import sys

SITE_DIR = "."

def main(file_name):
  reader = csv.reader(open(file_name))
  # Get rid of header row.
  reader.next()
  members = [{"name": "%s %s" % (row[1], row[2]), "username": row[4]} for row in reader if
             (len(row) == 10) and row[9] == "Y"]
  json.dump(members, open(os.path.join(SITE_DIR, "media/members.json"), "w"))

if __name__ == "__main__":
  try:
    main(sys.argv[1])
  except IndexError:
    print "Need one argument, the members csv you're importing."
