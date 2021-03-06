import React from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'
import axios from 'axios'
import { deserialize } from 'jsonapi-deserializer'

import { path } from '../../Routes'
import { useI18n } from '../../I18n'
import { useForm, Errors } from '../../Form'

import styles from './Show.module.css'
import page from '../../Page.module.css'
import form from '../../Form.module.css'
import buttons from '../../Buttons.module.css'

Show.propTypes = {
  user: PropTypes.object.isRequired,
  locale: PropTypes.string.isRequired
}

export default function Show ({ user: userJSON, locale }) {
  const I18n = useI18n(locale)
  const user = deserialize(userJSON)

  const {
    values,
    // setValues,
    // saved,
    // setSaved,
    handleInputChange,
    errors,
    pending,
    setErrors,
    onSubmit,
    cancelToken
  } = useForm({ password: '', password_confirmation: '', reset_password_token: user && user.reset_password_token })

  const handleSubmit = async e => {
    e.preventDefault()

    await axios.patch(
      path('account_password_path', { format: 'json' }),
      { user: values },
      { cancelToken: cancelToken.current.token }
    ).then(res => {
      if (res.headers.location) window.location = res.headers.location
      // setSaved(true)
    }).catch(error => {
      setErrors(error.response.data)
    })
  }

  return (
    <div className={page.gray}>
      <div className={page.title}>
        <h1>{I18n.t('accounts.passwords.show')}</h1>
      </div>

      <div className={styles.root}>
        <div className={form.tight}>
          {user &&
            <form className={classNames(form.root, styles.form)} onSubmit={onSubmit(handleSubmit)}>
              <Errors errors={errors.reset_password_token} />

              <div className={form.item}>
                <label>
                  <div className={form.label}>
                    {I18n.t('accounts.passwords.password')}
                  </div>

                  <div className={form.input}>
                    <input
                      type="password"
                      autoFocus
                      autoComplete="new-password"
                      value={values.password}
                      name="password"
                      onChange={handleInputChange}
                    />
                  </div>
                </label>

                <Errors errors={errors.password} />
              </div>

              <div className={form.item}>
                <label>
                  <div className={form.label}>
                    {I18n.t('accounts.passwords.password_confirmation')}
                  </div>

                  <div className={form.input}>
                    <input
                      type="password"
                      autoComplete="off"
                      value={values.password_confirmation}
                      name="password_confirmation"
                      onChange={handleInputChange}
                    />
                  </div>
                </label>

                <Errors errors={errors.password_confirmation} />
              </div>

              <div className={classNames(form.submit, styles.submit)}>
                <input
                  type="submit"
                  value={pending ? I18n.t('accounts.passwords.submiting') : I18n.t('accounts.passwords.submit')}
                  className={classNames(buttons.main, { [buttons.pending]: pending })}
                  disabled={pending}
                />
              </div>
            </form>
          }

          {!user &&
            <div>
              {I18n.t('accounts.passwords.no_token')}
            </div>
          }
        </div>
      </div>
    </div>
  )
}
