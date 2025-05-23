import re

dirname = "results"

def parse(filename):
    with open(f"{dirname}/{filename}.raw") as f:
        with open(f"{dirname}/{filename}.md", "w") as w:
            w.write("")
        full_content = re.sub(r"(: )|( :=)", ":", re.sub(r" +", " ", f.read()))
        titles = [re.sub(r"(\*,)|(,\*)", "", e[1:-1]).replace(",", ", ") for e in re.findall(r"\[.*\]", full_content)]
        if titles == []: titles = ["Wyniki"]
        sections = filter(lambda s: s != "", re.split(r"\n* *\[.*\] *\n", full_content))
        for title, content in zip(titles, sections):
            columns = " ".join([e[1:-2] for e in re.findall(r":.*:\n", content)]).split(" ")
            rows = [e.split(" ")[0] for e in re.sub(r":.*:\n", "", content.split("\n\n")[0]).split("\n")]
            data = {}
            for column in columns:
                data[column] = []
            i = 0
            for page in content.split("\n\n"):
                page_content = [" ".join(e.split(" ")[1:]) for e in re.sub(r":.*:\n", "", page).split("\n")]
                for row in page_content:
                    for j, value in enumerate(row.split(" ")):
                        data[columns[i+j]].append(value)
                i += len(page_content[0].split(" "))
            
            table = "|     |"
            for column in sorted(columns):
                table += f" {column} |"
            table += "\n| --- |"
            for column in sorted(columns):
                table += f" {'-' * len(column)} |"
            for i, row in enumerate(rows):
                table += f"\n| {row:3} |"
                for column in sorted(columns):
                    table += f" {float(data[column][i]):.2f} |"
            
            with open(f"{dirname}/{filename}.md", "a") as w:
                w.write(f"\n### {title}\n")
                w.write(table)


parse("sklepy_magazyny_produkty")
parse("sklepy_magazyny_laczne")
parse("transport_magazyny_sklepy")
parse("transport_producenci_magazyny")