import React, { Component } from 'react'
import classNames from 'classnames'
import axios from 'axios'
import AnimateHeight from 'react-animate-height'

import { path } from './Routes'

import styles from './Nav.module.css'

class Nav extends Component {
  state = {
    active: true,
    section: null
  }

  toggleSection = (section) => {
    this.setState(state => ({
      section: state.section == section ? null : section
    }))
  }

  handleLogout = async e => {
    e.preventDefault()

    try {
      await axios.delete(path('destroy_user_session_path'), { params: { authenticity_token: document.querySelector('[name="csrf-token"]').content }})
    } catch (err) {

    }

    window.location = path('root_path')
  }

  render() {
    const { active, section } = this.state
    const { user, categories, themes, collections } = this.props

    return (
      <nav className={classNames(styles.root, { [styles.active]: active })}>
        <Section id="categories" title="Онлайн магазин" onToggle={this.toggleSection} section={section}>
          <div className={styles.sub}>
            <a href={path('catalog_latest_path')}>New</a>
          </div>

          {categories.map(category =>
            <div className={styles.sub} key={category.id}>
              <a href={path('catalog_category_path', { slug: category.slug })}>{category.title}</a>
            </div>
          )}

          <div className={styles.sub}>
            <a href={path('catalog_sale_path')}>Sale</a>
          </div>

          <div className={styles.sub}>
            <a href={path('catalog_path')}>Посмотреть всё</a>
          </div>
        </Section>

        {/*
        <Section id="themes" title="Образы" onToggle={this.toggleSection} section={section}>
          <div className={styles.sub}>
            <a href={path('latest_themes_path')}>New</a>
          </div>

          {themes.map(theme =>
            <div className={styles.sub} key={theme.id}>
              <a href={path('theme_path', { id: theme.slug })}>
                {theme.title}
              </a>
            </div>
          )}

          <div className={styles.sub}>
            <a href={path('themes_path')}>Посмотреть всё</a>
          </div>
        </Section>
        */}

        <Section id="collections" title="Коллекции" onToggle={this.toggleSection} section={section}>
          {collections.map(collection =>
            <div className={classNames(styles.sub)} key={collection.id}>
              <a href={path('collection_path', { id: collection.slug })}>
                <div>
                  {collection.title}
                </div>
                {collection.desc &&
                  <div className={styles.collection}>
                    {collection.desc}
                  </div>
                }
              </a>
            </div>
          )}
        </Section>

        <div className={classNames(styles.section)}>
          <div className={styles.title}>
            <a href="/posts/1">
              О бренде
            </a>
          </div>
        </div>

        <div className={classNames(styles.section)}>
          <div className={styles.title}>
            <a href="/contacts">
              Места продаж
            </a>
          </div>
        </div>

        <Section id="customers" title="Покупателям" onToggle={this.toggleSection} section={section}>
          <div className={styles.sub}>
            <a href="/customers/info">Оплата и доставка</a>
          </div>

          <div className={styles.sub}>
            <a href="/customers/return">Обмен и возврат</a>
          </div>
        </Section>

        <div className={classNames(styles.section)}>
          <div className={styles.title}>
            <a href="/login">
              {user && !user['guest?'] ? 'Ваши заказы' : 'Войти'}
            </a>

            {user && !user['guest?'] &&
              <a className={styles.logout} href={path('destroy_user_session_path')} onClick={this.handleLogout}>
                Выйти
              </a>
            }
          </div>
        </div>

        {user && user['is_editor?'] &&
          <Section id="control" title="Управление" onToggle={this.toggleSection} section={section}>
            <div className={styles.sub}>
              <a href={path('orders_path')}>Заказы</a>
            </div>

            <div className={styles.sub}>
              <a href={path('collections_path')}>Коллекции</a>
            </div>

            <div className={styles.sub}>
              <a href={path('variants_path')}>Товары</a>
            </div>

            <div className={styles.sub}>
              <a href={path('categories_path')}>Категории</a>
            </div>


            <div className={styles.sub}>
              <a href={path('colors_path')}>Цвета</a>
            </div>

            <div className={styles.sub}>
              <a href={path('slides_path')}>Слайды</a>
            </div>
          </Section>
        }
      </nav>
    )
  }
}

function Arr(props) {
  return (
    <svg viewBox="0 0 10 24" className={styles.arr}>
      <polyline points="1 10 5 14 9 10" />
    </svg>
  )
}

class Section extends Component {
  isActive() {
    return this.props.section == this.props.id
  }

  render() {
    const { title, children, id, section } = this.props

    return (
      <div className={classNames(styles.section, { [styles.active]: this.isActive() })}>
        <div className={styles.title} onClick={() => this.props.onToggle(id)}>
          {title}
          <Arr />
        </div>

        {children &&
          <AnimateHeight className={styles.subs} duration={500} height={this.isActive() ? 'auto' : 0}>
            {children}
          </AnimateHeight>
        }
      </div>
    )
  }
}

export default Nav