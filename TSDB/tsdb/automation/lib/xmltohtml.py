import xml.etree.ElementTree as ET

# Specify the path to your XML file
xml_file_path = "/home/cavisson/work/TSDB/tsdb/automation/report.xml"

# Parse the XML file
tree = ET.parse(xml_file_path)
root = tree.getroot()

# Calculate overall summary
overall_total_tests = 0
overall_passed_tests = 0
overall_failed_tests = 0
overall_skipped_tests = 0
overall_total_time = 0.0

for testsuite in root.findall('.//testsuite'):
    total_tests = len(testsuite.findall('.//testcase'))
    failed_tests = len(testsuite.findall('.//testcase[failure]'))
    skipped_tests = len(testsuite.findall('.//testcase[skipped]'))

    # Calculate passed tests
    passed_tests = total_tests - (failed_tests + skipped_tests)

    overall_total_tests += total_tests
    overall_passed_tests += passed_tests
    overall_failed_tests += failed_tests
    overall_skipped_tests += skipped_tests
    overall_total_time += float(testsuite.get('time', 0.0))

# Calculate overall percentages
overall_pass_percentage = (overall_passed_tests / overall_total_tests) * 100 if overall_total_tests > 0 else 0
overall_fail_percentage = (overall_failed_tests / overall_total_tests) * 100 if overall_total_tests > 0 else 0
overall_skip_percentage = (overall_skipped_tests / overall_total_tests) * 100 if overall_total_tests > 0 else 0

# Generate HTML
html_content = """<html>
<head>
    <title>TSDB AUTOMATION REPORT</title>
    <style>
        table {
            border-collapse: collapse;
            margin: 16px auto;  /* Center the table */
        }
        th, td {
            text-align: center;  /* Center the text */
            border: 2px solid black;
            padding: 6px;  /* Adjusted padding */
            font-size: 15px;
        }
        th {
            background-color: #9acd32;
        }
        h2 {
            text-align: center;  /* Center the heading */
        }
        #overall-summary {
            width: 75%;  /* Adjusted width for Overall */
        }
        #summary-table {
            width: 75%;  /* Adjusted width for Table 1 */
        }
        #detailed-table {
            width: 90%;  /* Adjusted width for Table 2 */
        }
        .passed-cell {
            color: green;  /* Green color for Passed */
        }
        .failed-cell {
            color: red;  /* Red color for Failed */
        }
        .skipped-cell {
            color: orange;  /* Amber color for Skipped */
        }
    </style>
</head>
<body>
"""

# Overall Summary
html_content += "<h2>Overall Summary</h2>\n"
html_content += "<table id='overall-summary'>\n"
html_content += f"<tr><th>SuitName</th><th>TotalCases</th><th>Passed</th><th>Failed</th><th>Skipped</th><th>TotalExecutionTime</th></tr>\n"
html_content += f"<tr><td style='font-weight: bold;'>TSDB AUTOMATION REPORT</td><td style='font-weight: bold;'>{overall_total_tests}</td><td style='font-weight: bold;'>{overall_passed_tests}</td><td style='font-weight: bold;'>{overall_failed_tests}</td><td style='font-weight: bold;'>{overall_skipped_tests}</td><td style='font-weight: bold;' >{overall_total_time:.2f}</td></tr>\n"
html_content += "</table>\n"

# Table 1: Summary Table
html_content += "<h2>Summary Report</h2>\n"
html_content += "<table id='summary-table'>\n"
html_content += "<tr><th>Testsuite</th><th>TotalCases</th><th>Passed</th><th>Failed</th><th>Skipped</th><th>TotalExecutionTime</th></tr>\n"

for testsuite in root.findall('.//testsuite'):
    total_tests = len(testsuite.findall('.//testcase'))
    failed_tests = len(testsuite.findall('.//testcase[failure]'))
    skipped_tests = len(testsuite.findall('.//testcase[skipped]'))

    # Calculate passed tests
    passed_tests = total_tests - (failed_tests + skipped_tests)
    
    total_time = testsuite.get('time')
    
    # Set class for Passed and Skipped cells to apply styling
    passed_cell_class = "passed-cell" if failed_tests == 0 else ""
    failed_cell_class = "failed-cell" if failed_tests > 0 else ""
    skipped_cell_class = "skipped-cell" if skipped_tests > 0 else ""

    html_content += f"<tr><td style='font-weight: bold;'>{testsuite.get('name')}</td><td style='font-weight: bold;'>{total_tests}</td><td style='font-weight: bold;' class='{passed_cell_class}'>{passed_tests}</td><td style='font-weight: bold;' class='{failed_cell_class}'>{failed_tests}</td><td style='font-weight: bold;' class='{skipped_cell_class}'>{skipped_tests}</td><td style='font-weight: bold;'>{total_time}</td></tr>\n"

html_content += "</table>\n"

# Table 2: Detailed Test Results Table
html_content += "<h2>Test Results Summary</h2>\n"
html_content += "<table id='detailed-table'>\n"
html_content += "<tr><th>Testcase</th><th>Status</th><th>FailReason</th><th>Execution Time</th></tr>\n"

for testsuite in root.findall('.//testsuite'):
    for testcase in testsuite.findall('.//testcase'):
        status = "Pass"
        fail_reason = ""
        execution_time = testcase.get('time')

        failure_element = testcase.find('failure')
        skipped_element = testcase.find('skipped')

        if failure_element is not None:
            status = "Fail"
            fail_reason = failure_element.text
        elif skipped_element is not None:
            status = "Skipped"
            fail_reason = skipped_element.text

        html_content += f"<tr><td>{testcase.get('name')}</td><td style=\"color: {'#32CD32' if status == 'Pass' else ('#FFA500' if status == 'Skipped' else 'red')}; font-weight: bold;\">{status}</td><td style='font-size: 15px; width: 400px;'>{fail_reason}</td><td>{execution_time}</td></tr>\n"

html_content += "</table>\n"

html_content += "</body>\n</html>"

# Save or print the generated HTML
output_html_path = "/home/cavisson/work/TSDB/tsdb/automation/report.html"
with open(output_html_path, "w") as html_file:
    html_file.write(html_content)

print(f"HTML conversion complete. Results saved to: {output_html_path}")

