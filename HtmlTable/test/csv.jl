import Pkg
println(pwd())
if !isfile("Project.toml")
    println("Project.toml が見つからない。")
    exit(1)
end
Pkg.activate(".")
using HtmlTable
html = fromCSV("./test/data.csv", title="From CSV")
write("./test/result_csv.html", html)
println("test/result_csv.html が更新されました。")