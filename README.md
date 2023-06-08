## 

https://github.com/ideawu/ssdb 的 docker 镜像，基于 alpine 打包，定期更新基础镜像重新打包。



需要挂载目录
`/usr/local/ssdb/var`


运行
```
docker run  -v ssdb_data:/usr/local/ssdb/var:rw --restart=unless-stopped  -d chenjia404/ssdb-server
```

## 构建

```bash
docker build -t chenjia404/ssdb-server .

docker push chenjia404/ssdb-server
```