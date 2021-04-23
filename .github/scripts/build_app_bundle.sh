export storePassword="${{ secrets.GOOGLE_STORE_STOREPASSWORD }}"
export keyPassword="${{ secrets.GOOGLE_STORE_KEYPASSWORD }}"
export keyAlias="${{ secrets.GOOGLE_STORE_KEYALIAS }}"
export storeFile=release.keystore

flutter build appbundle