import html2docx

def convert_html_to_docx(input_html, output_docx):
    # Read the HTML content
    with open(input_html, "r", encoding="utf-8") as html_file:
        html_content = html_file.read()

    # Convert HTML to DOCX
    document = html2docx.convert(html_content)

    # Save the DOCX file
    document.save(output_docx)
    print(f"Conversion complete: {output_docx}")

# Example usage
input_html = 'task2.html'
output_docx = 'output.docx'
convert_html_to_docx(input_html, output_docx)

