import React, { Component } from 'react'
import axios from 'axios'

import { path } from '../Routes'
import I18n from '../I18n'

import List from './List'

import page from '../Page'

class Premium extends Component {
  state = {
    variants: null
  }

  componentDidMount = async () => {
    const res = await axios.get(path('catalog_premium_path', { format: 'json' }))
    this.setState({ ...res.data })
  }

  render () {
    const { variants } = this.state

    return (
      <div className={page.root}>
        <div className={page.title}>
          <h1>{I18n.t('variants.premium.title')}</h1>
        </div>

        <div>
          {variants &&
            <List variants={variants} />
          }
        </div>
      </div>
    )
  }
}

export default Premium
