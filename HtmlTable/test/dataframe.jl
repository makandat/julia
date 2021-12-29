import Pkg
println(pwd())
if !isfile("Project.toml")
    println("Project.toml が見つからない。")
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
println("test/result_df.html が更新されました。")