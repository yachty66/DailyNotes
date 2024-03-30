# DailyNotes

DailyNotes - Inside the Daily Notes folder, every day synced with the current time of the laptop, a new note with today's date is created. Once the app is installed, it runs continuously and never shuts off. The app automates this task for me, but I have made it public on GitHub with steps for setting it up to help others who want to do the same because I find it useful.

- [x] app checks if DailyNotes folder exists in apple notes and if not it creates one
- [x] app runs synced with current local time every day 00:01 and creates a new note with the date of today as header
- [x] is configured such as that app is starting every time mac launches - basically no probability that the app is not running every day
- [x] create script which when executed manually is creating a dailynotes folder if not exist
- [x] after checking point above also check if daily note exists and if not create itä
- [ ] add the day of the week plus make it a subheader
- [ ] check what the easiest way is to automate the process so that it is run every day 00:01 synced with current time - if its not possible to run the script if the mac sleeps need to find another solution  