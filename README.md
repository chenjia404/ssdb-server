## 

https://github.com/ideawu/ssdb 的 docker 镜像，基于 alpine 打包，定期更新基础镜像重新打包。

需要挂载两个目录

`/usr/local/ssdb/var/data`

`/usr/local/ssdb/var/meta`


运行
```
docker run  -v ssdb_data:/usr/local/ssdb/var/data:rw --v ssdb_meta:/usr/local/ssdb/var/meta:rw  --restart=unless-stopped  -d chenjia404/ssdb-server
```