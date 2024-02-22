        rm -fr charts/*
        rm -fr out/
        helm lint
        helm package -d charts .
         helm upgrade sample $(ls charts/origin-*.tgz) \
              --atomic --install
