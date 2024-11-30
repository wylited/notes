#!/bin/bash

# Define the calendar URLs
classes_calendar="https://calendar.google.com/calendar/ical/7h1bf27rqrev95i4s526hv5k07ig7gu1%40import.calendar.google.com/public/basic.ics"
holiday_calendar="https://calendar.google.com/calendar/ical/en.hong_kong%23holiday%40group.v.calendar.google.com/public/basic.ics" # Replace with the URL of the holiday calendar

# Function to convert ICS file to ORG format
convert_ics_to_org() {
    local ics_file="$1"
    local org_file="$2"

    awk -f ./ics2org.awk "$ics_file" > "../$org_file"
}

# Function to download and convert calendar file
process_calendar() {
    local calendar_url="$1"
    local calendar_name="$2"

    # Extract the filename from the URL
    filename=$(basename "$calendar_url")

    # Download the calendar file
    curl -o "$filename" "$calendar_url"

    # Convert ICS to ORG
    convert_ics_to_org "$filename" "$calendar_name.org"

    # Clean up the downloaded file
    rm "$filename"
}

# Process each calendar
process_calendar "$classes_calendar" "classes"
process_calendar "$holiday_calendar" "holiday"
