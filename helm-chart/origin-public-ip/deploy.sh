        rm -fr charts/*
        rm -fr out/
        helm lint
        helm package -d charts .
         helm upgrade origin-public-ip $(ls charts/origin-*.tgz) \
              --atomic --install
