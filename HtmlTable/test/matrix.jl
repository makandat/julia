import Pkg
println(pwd())
if !isfile("Project.toml")
    println("Project.toml が見つからない。")
    exit(1)
end
Pkg.activate(".")
using HtmlTable
A = [1000 200 430; 2050 560 870]
html = fromMatrix(A, ["A", "B", "C"])
write("./test/result_mat.html", html)
println("test/result_mat.html が更新されました。")