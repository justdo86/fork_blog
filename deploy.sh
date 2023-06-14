#!/usr/bin/env sh

# https://www.sojson.com/robots/ 生成Robots.txt
# https://www.xml-sitemaps.com/  生成sitemap.xml站点地图

# 确保脚本抛出遇到的错误
set -e
# fd0073ed132eb69233860692ecb5cae8cafa61aa
basepath=$(cd `dirname $0`; pwd)
sourcePath=$basepath'/docs/.vuepress/dist/'

# 遍历html 插入友盟
function fileForEach() {
    for file in `ls $1`
    do 
        if [ -d $1"/"$file ]
        then
            if [ -n "`find $1$file -maxdepth 1 -name '*.html'`" ];
            then
                echo $1$file"/"*.html
                sed -i '/</head>\</head><script>var _hmt = _hmt || [];(function() {var hm = document.createElement("script");hm.src = "https://hm.baidu.com/hm.js?03fcbc1674d5d46ad9125d7e0dbb5d51";var s = document.getElementsByTagName("script")[0]; s.parentNode.insertBefore(hm, s);})();</script>' $1$file"/"*.html
            fi
        fi
    done
}

echo "开始构建项目"
# 生成静态文件
npm run build
echo "构建完毕"

fileForEach $sourcePath

cd $sourcePath

# echo "添加友盟代码"
# # ergodic $sourcePath
# sed -i '' '/<\/body/a\ 
# <script type="text/javascript" src="https://s9.cnzz.com/z_stat.php?id=1277950578&web_id=1277950578"></script><style>body>a{display:none!important;}</style>' $sourcePath'/index.html'
# echo "添加代码执行完毕"

# 如果是发布到自定义域名
# echo 'www.example.com' > CNAME
git init
git config user.name "HerryLo"
git config user.email "herryloyopai@163.com"
git add -A
git commit -m 'deploy'

# 如果发布到 https://<USERNAME>.github.io
# git push -f git@github.com:HerryLo/HerryLo.github.io.git master
# 如果发布到 https://<USERNAME>.github.io/<REPO>
# git push -f git@github.com:<USERNAME>/<REPO>.git master:gh-pages

git push -f git@github.com:HerryLo/HerryLo.github.io.git master

# git push -f https://${access_token}@github.com/HerryLo/HerryLo.github.io.git master

cd -