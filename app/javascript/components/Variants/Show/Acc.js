import React, { Component } from 'react'
import classNames from 'classnames'
import AnimateHeight from 'react-animate-height'

import styles from './Acc.module.css'

class Acc extends Component {
  state = {
    active: false
  }

  isActive() {
    return this.props.section == this.props.id
  }

  render () {
    const { title, children, id } = this.props

    return (
      <div className={classNames(styles.root, { [styles.active]: this.isActive() })}>
        <div className={styles.title} onClick={() => this.props.onToggle(id)}>
          {title}
          <Arr />
        </div>

        {children &&
          <AnimateHeight className={styles.content} duration={500} height={this.isActive() ? 'auto' : 0}>
            <div className={styles.ch}>
              {children}
            </div>
          </AnimateHeight>
        }
      </div>
    )
  }
}

function Arr(props) {
  return (
    <svg viewBox="0 0 10 20" className={styles.arr}>
      <polyline points="1 8 5 12 9 8" />
    </svg>
  )
}

export default Acc
