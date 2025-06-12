function docker-run
  # set fish_trace true
  switch $argv[1]
    case "emby"
      run-emby $argv[2..-1]
    case "stirling"
      run-stirling-pdf $argv[2..-1]
    case "thunder"
      run-thunder $argv[2..-1]
    case "*"
      echo "Available Command:"
      echo "1.emby"
      echo "2.stirling"
      echo "3.thunder"
  end
end

function run-emby
  if test (count $argv) -lt 2
    echo "Usage: emby <config path> <share1 path> [extra docker options]"
    # --device nvidia.com/gpu=all \
    return
  end
  docker run -d \
    --name embyserver \
    --volume $argv[1]:/config \
    --volume $argv[2]:/mnt/share1 \
    --device /dev/dri:/dev/dri \
    --publish 8096:8096 \
    --publish 8920:8920 \
    --env ALL_PROXY=http://172.17.0.1:7897 \
    --env HTTP_PROXY=http://172.17.0.1:7897 \
    --env HTTPS_PROXY=http://172.17.0.1:7897 \
    --env NO_PROXY=localhost,172.17.0.1,127.0.0.1 \
    --env UID=(id -u) \
    --env GID=(id -g) \
    $argv[3..-1] \
    emby/embyserver:latest
  echo "Please visit http://localhost:8096 to use the service."
end

function run-stirling-pdf
  if test (count $argv) -lt 1
    echo "Usage: stirling <config path> [extra docker options]"
    return
  end
  docker run -d \
    --name stirling-pdf \
    -p 5716:8080 \
    -v $argv[1]/trainingData:/usr/share/tessdata \
    -v $argv[1]/extraConfigs:/configs \
    -v $argv[1]/customFiles:/customFiles/ \
    -v $argv[1]/logs:/logs/ \
    -v $argv[1]/pipeline:/pipeline/ \
    -e DOCKER_ENABLE_SECURITY=false \
    -e LANGS=zh_CN \
    $argv[2..-1] \
    docker.stirlingpdf.com/stirlingtools/stirling-pdf:latest
  echo "Please visit http://localhost:5716 to use the service."
end

function run-thunder
  if test (count $argv) -lt 2
    echo "Usage: run-thunder <config path> <downloads path> [extra docker options]"
    return
  end
  docker run -d \
    --name=thunder \
    --hostname=thunder \
    --net=host \
    -v $argv[1]:/xunlei/data \
    -v $argv[2]:/xunlei/downloads \
    --privileged \
    $argv[3..-1] \
    cesign/xunlei:latest
  echo "Please visit http://localhost:2345 to use the service."
end