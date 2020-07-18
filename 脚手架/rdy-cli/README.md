## rdy-cli 项目脚手架
<!-- 1. rdycli add # add template
2. rdycli delete template-name # delete template
3. rdycli list # check all template list
4. rdycli init template-name url # init project  -->

1. 需要添加模板 ` rdycli add `,然后会让你填写模板名称，及模板地址


2. 添加自己所需的模板之后，可以去初始项目了。`rdycli init`，在填写提示的一些参数之后，初始项目会从`template.json`中拉去所需要的模板资源, 这里会有点慢，请耐心等候
PS：这里gitlab 如果是有ip组成，默认使用node 自带 `exec`去下载，否则使用 `download-git-repo`远程下载

3. `rdycli delete` ，填写模板名称，删除模板
4. `rdycli list` ，查看所有模板名