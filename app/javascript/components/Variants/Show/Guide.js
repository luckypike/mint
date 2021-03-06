import React, { useState } from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'

// import I18n from '../../I18n'
import { useI18n } from '../../I18n'

import styles from './Guide.module.css'
// import Fonts from '../../Fonts.module.css'

Guide.propTypes = {
  locale: PropTypes.string
}

export default function Guide ({ locale }) {
  const I18n = useI18n(locale)

  const [active, setActive] = useState(false)

  return (
    <>
      <div
        className={classNames(styles.overlay, { [styles.active]: active })}
        onClick={() => setActive(false)}
      />

      <div className={styles.text} onClick={() => setActive(true)}>
        <span>
          {I18n.t('variant.size.guide.title')}
        </span>
      </div>

      <div className={classNames({ [styles.size_helper]: active, [styles.size_help]: !active })}>
        <div className={styles.close} onClick={() => setActive(false)}>
          <svg viewBox="0 0 16 16">
            <line x1="1" y1="1" x2="15" y2="15" stroke="var(--pr_color)" />
            <line x1="1" y1="15" x2="15" y2="1" stroke="var(--pr_color)" />
          </svg>
        </div>

        <div className={styles.row}>
          <div className={styles.v}>
            {I18n.t('variant.size.guide.size')}
          </div>

          <div className={styles.v}>
            {I18n.t('variant.size.guide.bust')}
          </div>

          <div className={styles.v}>
            {I18n.t('variant.size.guide.waist')}
          </div>

          <div className={styles.v}>
            {I18n.t('variant.size.guide.hips')}
          </div>
        </div>

        <div className={styles.row}>
          <div>
            XS
          </div>

          <div>
            84
          </div>

          <div>
            64
          </div>

          <div>
            92
          </div>
        </div>

        <div className={styles.row}>
          <div>
            S
          </div>

          <div>
            88
          </div>

          <div>
            68
          </div>

          <div>
            96
          </div>
        </div>

        <div className={styles.row}>
          <div>
            M
          </div>

          <div>
            92
          </div>

          <div>
            72
          </div>

          <div>
            100
          </div>
        </div>

        <div className={styles.row}>
          <div>
            L
          </div>

          <div>
            96
          </div>

          <div>
            76
          </div>

          <div>
            104
          </div>
        </div>
      </div>
    </>
  )
}
