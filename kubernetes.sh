kc() {
  local -r ctx="$1"
  if [[ $ctx ]]; then
    kubectl config use-context "$ctx"
    export TILLER_NAMESPACE="$(kubectl config get-contexts | grep "*" |awk '{print $5}')"
  else
    kubectl config get-contexts | sort -d
  fi
}
_kc() {
  local cur
  if declare -F _init_completions >/dev/null 2>&1; then
      _init_completion
  else
      _get_comp_words_by_ref cur prev words cword
  fi
  local -r ctxs="$(kubectl config get-contexts -o name)"
  COMPREPLY=($(compgen -W "$ctxs" -- "$cur"))
}
complete -F _kc kc

function kexec() {
  kubectl exec "$@"
}

function get_pods_for_app {
  kubectl get pods -l app="$@"
}
