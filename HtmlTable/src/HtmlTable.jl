# HTML 作成
module HtmlTable
using DataFrames
using CSV
using Tables

export fromDataFrame, fromMatrix, fromCSV

# HTML 文書のテンプレート
const HTMLFMT = """<!DOCTYPE html>
<html>
<head>
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <meta charset="utf-8" />
  <title>%title</title>
  <style>%style</style>
</head>

<body>
  <h1>%title</h1>
  <hr />
    %table
</body>
</html>"""

# スタイル
css = """\n
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
}\n
"""

# HTML の 特殊文字をエスケープするかどうかのフラグ
flagEscape = true

# HTML の 特殊文字をエスケープする。
function htmlEscape(text::String)
    return replace(text, "&"=>"&amp;", "<"=>"&lt;", ">"=>"&gt;")
end

# HTML タグを作る。
function tag(tagname::String, text::Any; escape=true, style="")
    tagn = tagname
    if style != ""
        tagn *= " "
        tagn *= style
    end
    if escape
        return "<" * tagn * ">" * htmlEscape(string(text)) * "</" * tagname * ">"
    else
        return "<" * tagn * ">" * text * "</" * tagname * ">"
    end
end


# テーブル行を作る。
function tableRow(data::Vector; th=false, rown=-1)
    td = th ? "th" : "td"
    html = "<tr>"
    # 行番号を付けるかどうか
    if rown == 0
        html *= tag(td, "Row", style="style=\"width:100px;\"")  # 表題行の場合
    elseif rown > 0
        html *= tag(td, rown)  # 表題行でない場合
    else
        # rown < 0 のときは行番号なし。
    end
    for d = data
        html *= tag(td, d, escape=flagEscape)
    end
    html *= "</tr>\n"
    return html
end

# Matrix を元に作成する。
function fromMatrix(mat::Matrix, columns::Vector; title="HTML Table", rownum=false)
    table = "<table>\n<thead>\n"
    table *= tableRow(columns, th=true, rown=rownum ? 0 : -1)
    table *= "</thead>\n<tbody>\n"
    nrow, ncol = size(mat)
    for i = 1:nrow
        table *= tableRow(mat[i, :], rown=rownum ? i : -1)
    end
    table *= "</tbody>\n</table>\n"
    replace(HTMLFMT, "%title" => title, "%table" => table, "%style" =>css)
end

# DataFrame を元に作成する。
function fromDataFrame(df::DataFrame; title="HTML Table", rownum=false)
    columns = names(df)
    mat = Tables.matrix(df)
    fromMatrix(mat, columns, title=title, rownum=rownum)
end

# CSV ファイルを元に作成する。
function fromCSV(path::String; header=true, delimtter=",", stripQuote=true, title="HTML Table", rownum=false)
    df = DataFrame(CSV.File(path, header=header, quoted=stripQuote))
    fromDataFrame(df, title=title, rownum=rownum)
end

end # HtmlTable
