import React, { Component } from 'react'
import axios from 'axios'
import classNames from 'classnames'
import update from 'immutability-helper'

import { path } from '../Routes'

import ProductForm from './ProductForm'
import Images from '../Images/Images'

import buttons from '../Buttons.module.css'
import page from '../Page.module.css'
import form from '../Form.module.css'
import styles from './Variant.module.css'

class Form extends React.Component {
  state = {
    values: this.props,
    dictionaries: {
      colors: [],
      stores: [],
      sizes: [],
    },
  }

  componentDidMount() {
    if (this.props.id) {
      this._loadAsyncData(this.props.id);
    }
  }

  render () {
    const { title, id } = this.props
    const { values, active_sizes } = this.state
    const { colors, stores, sizes } = this.state.dictionaries

    if (!values) return null;

    if (values.availabilities_attributes) {
      values.availabilities_attributes.filter(s => s.store_id == 1).map((size, key) => {
      });
    }

    return (
      <div className={page.gray}>
        <div className={page.title}>
          <h1>Редактирование: {title}</h1>
        </div>

        <div className={form.root}>
          <ProductForm values={values.product_attributes} onChange={this.handleProductChange}/>
          <form onSubmit={this.handleSubmit}>

            <div className={form.input}>
              <div className={form.label}>
                Цвет
              </div>

              <div className={form.input_input}>
                <select name="color_id" onChange={this.handleInputChange} value={values.color_id}>
                  <option />
                  {colors.map(color =>
                    <option key={color.id} value={color.id}>{color.title}</option>
                  )}
                </select>
              </div>
            </div>

            <div className={form.stores}>
              {stores.map((store, _) =>
                <>
                  <div className={form.store}>
                    <div className={form.input}>
                      <div className={form.label}>
                        Доступные размеры для {store.title}
                      </div>

                      <div className={styles.sizes}>
                        {sizes.map((size, _) =>
                          <div key={_} className={classNames([styles.size], {[styles.active]: values.availabilities_attributes.find(s => s.size_id == size.id && s.store_id == store.id && !s._destroy)})} onClick={() => this.handleSizesChange(store.id, size.id)}>{size.size}</div>
                        )}
                      </div>
                    </div>
                  </div>

                  {values.availabilities_attributes && values.availabilities_attributes.filter(s => s.store_id == store.id )&&
                    values.availabilities_attributes.filter(s => s.store_id == store.id && !s._destroy).map((size, key) =>
                      <div key={key} className={form.input}>
                        <div className={form.label}>
                          Количество размера "{sizes.find(s => s.id == size.size_id).size}"
                        </div>

                        <div className={form.input_input}>
                          <input type="text" value={size.count} name={`size[${size.size_id}]`} onChange={this.handleQuantityChange(store.id, size.size_id)} />
                        </div>
                      </div>
                    )
                  }
                </>
              )}
            </div>

            <Images images={values.images} onImagesChange={this.handleImagesChange}/>

            <div>
              <input className={buttons.main} type="submit" value="Сохранить" />
            </div>
          </form>

        </div>
      </div>
    )
  }

  _loadAsyncData(id) {
    this._asyncRequest = axios.CancelToken.source();

    axios.get(path('edit_variant_path', {id: id, format: 'json' }), { authenticity_token: document.querySelector('[name="csrf-token"]').content})
      .then(res => {
        this.setState({
          values: res.data.variant,
          dictionaries: {
            colors: res.data.colors,
            stores: res.data.stores,
            sizes: res.data.sizes,
          },
          active_sizes: res.data.variant.active_sizes,
        });

        this._asyncRequest = null;
      });
  }

  handleInputChange = event => {
    const target = event.target
    const value = target.type === 'checkbox' ? target.checked : target.value
    const name = target.name

    this.setState(state => ({
      values: { ...state.values, [name]: value }
    }))
  }

  handleQuantityChange = (store, size) => (event) => {
    const target = event.target
    const value = target.value

    let key = Object.keys(this.state.values.availabilities_attributes).find(s => this.state.values.availabilities_attributes[s].size_id == size && this.state.values.availabilities_attributes[s].store_id == store);

    const availabilities = update(this.state.values.availabilities_attributes, {
      [key]: {
        count: {
          $set: value
        }
      }
    });

    this.setState(state => ({
      values: { ...state.values,
        availabilities_attributes: availabilities
      }
    }))
  }


  handleSubmit = event => {
    this._handleUpdate()
    event.preventDefault()
  }

  _handleUpdate = async () => {
    const res = await axios.patch(
      path('variant_path', { id: this.props.id }),
      { variant: this.state.values, authenticity_token: document.querySelector('[name="csrf-token"]').content }
    )

    if(res.headers.location) window.location = res.headers.location
  }

  handleProductChange = (product) => {
    this.setState(state => ({
      values: { ...state.values, product_attributes: product }
    }))
  }

  handleSizesChange = (store, size) => {
    if (this.state.values.availabilities_attributes.find(s => s.size_id == size && s.store_id == store)) {
      let key = Object.keys(this.state.values.availabilities_attributes).find(s => this.state.values.availabilities_attributes[s].size_id == size && this.state.values.availabilities_attributes[s].store_id == store);

      const availabilities = update(this.state.values.availabilities_attributes, {
        [key]: {
          _destroy: {
            $set: !this.state.values.availabilities_attributes[key]._destroy
          }
        }
      });

      this.setState(state => ({
        values: { ...state.values,
          availabilities_attributes: availabilities
        }
      }))
    }
    else {
      this.setState(state => ({
        values: { ...state.values,
          availabilities_attributes: [ ...state.values.availabilities_attributes, {
            store_id: store,
            size_id: size,
            variant_id: this.props.id,
            count: 0,
            _destroy: false
          }]
        }
      }))
    }
  }

  handleImagesChange = (images) => {
    this.setState(state => ({
      values: { ...state.values,
        image_ids: images.map(i => i.id)
      }
    }))
  }
}

export default Form
