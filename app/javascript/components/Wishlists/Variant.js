import React, { useState, useEffect } from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'
import axios from 'axios'
import PubSub from 'pubsub-js'

import { useForm } from '../Form'
import Image from './Image'
import Guide from '../Variants/Show/Guide'

import { path } from '../Routes'
import Price from '../Variants/Price'
import I18n from '../I18n'
import Wishlist from '../Variants/Wishlist'

import styles from './Variant.module.css'
import buttons from '../Buttons.module.css'

Variant.propTypes = {
  variant: PropTypes.object.isRequired,
  locale: PropTypes.string.isRequired,
  onRemove: PropTypes.func
}

export default function Variant ({ variant, locale, onRemove }) {
  const {
    pending,
    onSubmit,
    cancelToken
  } = useForm()

  const [size, setSize] = useState()
  const [noSize, setNoSize] = useState(false)
  const [preorderWarning, setPreorderWarning] = useState(false)

  useEffect(() => {
    if (variant) {
      if (variant.availabilities.length === 1 && variant.availabilities[0].size.id === 1 && variant.availabilities[0].active) {
        setSize(variant.availabilities[0].size)
      } else {
        setSize()
      }
      setNoSize(false)
    }
  }, [variant])

  const handleCartClick = async e => {
    if (!size) {
      setNoSize(true)
      return
    }

    setNoSize(false)

    await axios.post(
      path('cart_variant_path', { id: variant.id, format: 'json' }),
      {
        size: size.id
      },
      { cancelToken: cancelToken.current.token }
    ).then(res => {
      setSize()
      setPreorderWarning(false)
      PubSub.publish('update-cart', res.data.quantity)
      PubSub.publish('notification-cart', variant)
    }).catch(_error => {
    })
  }

  return (
    <div className={styles.item}>
      <a href={path('catalog_variant_path', { slug: variant.category.slug, id: variant.id })} className={styles.image}>
        <Image
          variant={variant}
          onRemove={onRemove}
        />
      </a>

      <div className={styles.dt}>
        <div className={styles.top}>
          {variant.label &&
            <div className={classNames(styles.label, styles[variant.label])}>
              {I18n.t(`variant.labels.${variant.label}`)}
            </div>
          }

          {variant.state === 'unpub' &&
            <div className={styles.unpub}>
              {I18n.t('variant.unpub')}
            </div>
          }

          <div className={styles.title}>
            {variant.title}
          </div>

          {variant.price_sell > 0 &&
            <div className={styles.price}>
              <Price sell={parseFloat(variant.price_sell)} origin={parseFloat(variant.price)} />
            </div>
          }
        </div>

        {variant.availabilities.filter(a => a.active || variant.preorder).length > 0 &&
          <>
            <div className={styles.sizesWith}>
              <div className={styles.sizes}>
                {variant.availabilities.map(availability =>
                  <div
                    key={availability.size.id}
                    className={classNames(
                      styles.size,
                      styles[`size_${availability.size.id}`],
                      { [styles.unavailable]: (!availability.active && !variant.preorder), [styles.active]: size && availability.size.id === size.id }
                    )}
                    onClick={() => {
                      if (availability.active || variant.preorder) {
                        setSize(availability.size)
                        setPreorderWarning(!availability.active)
                      }
                    }}
                  >
                    {availability.size.title}
                  </div>
                )}
              </div>

              {preorderWarning &&
                <div className={styles.preorder}>
                  {I18n.t('variant.preorder')}
                </div>
              }

              <div className={styles.guide}>
                <Guide locale={locale} />
              </div>
            </div>

            <div className={styles.buy}>
              <div className={styles.cart}>
                <button
                  className={classNames(buttons.main, { [buttons.pending]: pending })}
                  disabled={pending}
                  onClick={onSubmit(handleCartClick)}
                >
                  {!pending ? I18n.t('wishlist.variant.cart.add') : I18n.t('wishlist.variant.cart.processing')}
                </button>

                {noSize &&
                  <div className={styles.noSize}>{I18n.t('variant.size.select')}</div>
                }
              </div>
            </div>
          </>
        }

        <div className={styles.wishlist}>
          <Wishlist
            variant={variant}
          />
        </div>
      </div>
    </div>
  )
}
