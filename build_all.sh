#! /bin/bash
cd oidc-rp/
./build_oidc-rp.sh
cd ..

cd ssp-idp/
./build_ssp-idp.sh
cd ..

cd eduteams-dev/
./build_svs.sh
cd ..
