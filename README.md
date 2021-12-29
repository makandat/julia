# julia/HtmlTable
Julia packages include only 'HtmlTable' package which has three functions below

## 1. function fromMatrix(mat::Matrix, columns::Vector; title="HTML Table", rownum=false)
This function generates a HTML document from the Matrix 'mat'.

### Parameters
 mat: Matrix input
 columns: Column names of the matrix 'mat'.
 title: HTML title and h1 header.
 rownum: If true then append the row number column.

### Return value
 HTML which is generated from the matrix 'mat'.
 

## 2. function fromDataFrame(df::DataFrame; title="HTML Table", rownum=false)
This function generates a HTML document from the DataFrame 'df'.

### Parameters
 df: DataFrame input.
 title: HTML title and h1 header.
 rownum: If true then append the row number column.

### Return value
 HTML which is generated from the DataFrame 'df'.
 
## 3. function fromCSV(path::String; header=true, delimter=",", stripQuote=true, title="HTML Table", rownum=false)
 This function generates a HTML document from the CSV file which path is 'path'.

### Parameters
 path: The path of the CSV file.
 header: If true then the first row is column names.
 delimiter: A character as separator between columns.
 title: HTML title and h1 header.
 rownum: If true then append the row number column.

## Sample program

### How to run.
 $ cd /home/user/workspace/julia/HtmlTable # for example
 $ julia test/dataframe.jl

```import Pkg
println(pwd())
if !isfile("Project.toml")
    println("Project.toml is not found.")
    exit(1)
end
Pkg.activate(".")
using HtmlTable, DataFrames
M = [
    "Jun. 2020" 1001 5;
    "Jun. 2020" 2055 12;
    "Jul. 2020" 1201 4;
    "Aug. 2020" 1001 5;
    "Aug. 2020" 2301 9;
    "Aug. 2020" 3002 18;
    "Sep. 2020" 1001 16;
    "Oct. 2020" 1201 3;
]
df = DataFrame(M, [:MONTH, :CODE, :AMOUNT])
html = fromDataFrame(df, title="From DataFrame")
write("./test/result_df.html", html)
println("test/result_df.html が更新されました。")```

## Output example

```<!DOCTYPE html>
<html>
<head>
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <meta charset="utf-8" />
  <title>From DataFrame</title>
  <style>

body {
    margin-left:3%;
    margin-right:3%;
}

h1 {
    text-align:center;
    padding:10px;
}

hr {
    margin-bottom:20px;
}

table {
    width:100%;
    border: solid thin gray;
    color: dimgray;
    border-collapse:collapse;
    margin-top:30px;
    margin-bottom:40px;
}

th {
    border: solid thin gray;
    background-color: azure;
    padding:3px;
    border-collapse:collapse;
}

td {
    border: solid thin gray;
    font-size:small;
    padding:3px;
    border-collapse:collapse;
}

</style>
</head>

<body>
  <h1>From DataFrame</h1>
  <hr />
    <table>
<thead>
<tr><th>MONTH</th><th>CODE</th><th>AMOUNT</th></tr>
</thead>
<tbody>
<tr><td>Jun. 2020</td><td>1001</td><td>5</td></tr>
<tr><td>Jun. 2020</td><td>2055</td><td>12</td></tr>
<tr><td>Jul. 2020</td><td>1201</td><td>4</td></tr>
<tr><td>Aug. 2020</td><td>1001</td><td>5</td></tr>
<tr><td>Aug. 2020</td><td>2301</td><td>9</td></tr>
<tr><td>Aug. 2020</td><td>3002</td><td>18</td></tr>
<tr><td>Sep. 2020</td><td>1001</td><td>16</td></tr>
<tr><td>Oct. 2020</td><td>1201</td><td>3</td></tr>
</tbody>
</table>

</body>
</html>```
 
