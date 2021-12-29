import Pkg
println(pwd())
if !isfile("Project.toml")
    println("Project.toml が見つからない。")
    exit(1)
end
Pkg.activate(".")
using HtmlTable, DataFrames
A = [1000 200 430; 2050 560 870]
html = fromMatrix(A, ["A", "B", "C"], rownum=true)
write("./test/result1.html", html)
df = DataFrame(A, [:A, :B, :C])
html = fromDataFrame(df, rownum=true)
write("./test/result2.html", html)
html = fromCSV("./test/data.csv", rownum=true)
write("./test/result3.html", html)
println("test/result1.html, test/result2.html, test/result3.htmlなどが更新されました。")