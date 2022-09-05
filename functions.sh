mkstg() {
    NAME="${1}"
    BASE="stemcell_builder/stages"

    CALL_SCRIPT="bosh-stemcell/lib/bosh/stemcell/stage_collection.rb"
    CALL_SCRIPT_SPEC="bosh-stemcell/spec/bosh/stemcell/stage_collection_spec.rb"

    HEADER="#!/usr/bin/env bash
    set -e

    base_dir=\$(readlink -nf \$(dirname \$0)/../..)
    source \$base_dir/lib/prelude_apply.bash
    "

    if [[ "${PWD##*/}" != bosh-linux-stemcell-builder ]]; then
        printf "Wrong directory: %s" ${PWD}
        return
    fi

    mkdir ${BASE}/${NAME}
    if (( $? == 0 )); then
        echo "${HEADER}" | sed -e "s/^[ \t]*//" > ${BASE}/${NAME}/apply.sh
        chmod u+x ${BASE}/${NAME}/apply.sh
        sed -i "262i \        :${NAME}," ${CALL_SCRIPT} 
        sed -i "32i \            :${NAME}," ${CALL_SCRIPT_SPEC}
    fi

    echo "${BASE}/${NAME}/apply.sh"
}
