#!/bin/bash

function scan_image()
{
    app_name=${1:-webapp}

    output="junit-report-${app_name}.xml"
    version="1.0"
    image_name="${pitstop}/${app_name}:${version}"
    echo "scanning ${app_name}"
    trivy image --severity LOW,MEDIUM,HIGH,CRITICAL \
    --format template --template "@contrib/junit.tpl" \ 
    --ignore-unfixed -o junit-report-${app_name}.xml \
    ${image_name}

    echo "Scan completed test report generated at junit-report-${app_name}.xml"
}

file_path="scan/allservices.txt"

# Check if the file exists
if [ ! -f "$file_path" ]; then
  echo "File not found: $file_path"
  exit 1
fi

# Loop over each line in the file (each line is treated as a separate string)
while IFS= read -r app; do
  scan_image "$app"
done < "$file_path"
