import axios from 'axios'

export function useAxios () {
  axios.defaults.params = {}
  axios.defaults.params.authenticity_token = document.querySelector('[name="csrf-token"]').content

  return axios
}
