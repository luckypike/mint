import '../css/variables'
import '../css/app'
import 'normalize.css/normalize'
// import 'react-phone-number-input/style.css'
import 'react-phone-input-2/lib/style.css'
import '@glidejs/glide/dist/css/glide.core'

import axios from 'axios'

window.axiosActive = 0

axios.interceptors.request.use((config) => {
  window.axiosActive += 1
  return config
})

axios.interceptors.response.use((response) => {
  window.axiosActive -= 1
  return response
})

var componentRequireContext = require.context('components', true)
var ReactRailsUJS = require('react_ujs')
ReactRailsUJS.useContext(componentRequireContext)
ReactRailsUJS.mountComponents()
