if [ -f ${BOOTLOADER_PATH}/.locale ]; then
  export LC_ALL="$(cat ${BOOTLOADER_PATH}/.locale)"
else
  export LC_ALL="en_US.UTF-8"
fi

#codes_lang=(en_US ar_YE ca_ES de_DE el_GR es_ES es_MX eu_ES fr_FR hu_HU it_IT ja_JP ko_KR nb_NO nl_NL nn_NO oc_FR pl_PL pt_BR pt_PT ru_RU uk_UA sv_SE tr_TR zh_CN zh_TW)

codes_lang=(en_US fr_FR zh_CN)

declare -A available_locales
export available_locales

for code_lang in "${codes_lang[@]}"; do
  code_lang_reduce=${code_lang%%_*}
  available_locales[${code_lang}]=$(jq ".${code_lang_reduce}.nativeName" "${INCLUDE_PATH}/iso_639-1.json")
done

alias TEXT='gettext "arpl"'
shopt -s expand_aliases
