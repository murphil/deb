function xzrm {
  local i
  for i in $*
    tar Jcvf ${i}.`date +%Y%m%d%H%M%S`.txz ${i} && rm -rf ${i}
}

function zsbk {
  local i
  for i in $*
    tar cvf - ${i} | zstd -c > ${i}.`date +%Y%m%d%H%M%S`.tar.zst && rm -rf ${i}
}

function zstc {
  local i
  for i in $*
    tar cvf - ${i} | zstd -c > ${i}.tar.zst
}
function zstx {
  local i
  for i in $*
    zstd -d ${i}.tar.zst && tar xvf ${i}.tar && rm -f ${i}.tar
}