import React, { useEffect, useState, useRef } from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'
import classNames from 'classnames'
import { deserialize } from 'jsonapi-deserializer'

import { path } from '../Routes'
import ErrorBoundary from '../ErrorBoundary'
import { useI18n } from '../I18n'

import styles from './Index.module.css'

Index.propTypes = {
  slides: PropTypes.object,
  instagram: PropTypes.string,
  locale: PropTypes.string
}

export default function Index ({ slides: slidesJSON, instagram, locale }) {
  const slides = deserialize(slidesJSON)

  const I18n = useI18n(locale)

  const [posts, setPosts] = useState()

  useEffect(() => {
    const _fetch = async () => {
      const { data } = await axios.get(path('instagram_path', { format: 'json' }))

      setPosts(data.posts)
    }

    _fetch()
  }, [])

  return (
    <ErrorBoundary>
      <div className={styles.root}>
        <div className={classNames(styles.slides, { [styles.single]: slides.length === 1 })} id="slides">
          {slides.slice(0, 1).map(slide =>
            <Slide
              key={slide.id}
              slide={slide}
              slideClassName={styles.slide}
            />
          )}
        </div>

        <div className={styles.content}>
          {slides.length > 1 &&
            <div className={styles.subslides}>
              {slides.slice(1, slides.length).map(slide =>
                <Slide
                  key={slide.id}
                  slide={slide}
                  slideClassName={styles.subslide}
                />
              )}
            </div>
          }

          <a target="_blank" href={instagram} rel="noopener noreferrer" className={styles.instagram}>
            golovina.brand
          </a>

          {posts &&
            <div className={styles.posts}>
              {posts.map(post =>
                <a key={post.id} className={styles.post} target="_blank" href={post.permalink} rel="noopener noreferrer">

                  {post.media_type === 'VIDEO' &&
                    <video autoPlay loop muted>
                      <source src={post.media_url} />
                    </video>
                  }

                  {(post.media_type === 'CAROUSEL_ALBUM' || post.media_type === 'IMAGE') &&
                    <img src={post.media_url} />
                  }
                </a>
              )}
            </div>
          }
        </div>

        <div className={styles.footer}>
          <div className={styles.mail}>
            <div>
              {I18n.t('static.index.email')}
            </div>
            <a href="mailto:shop@golovina.store">shop@golovina.store</a>
          </div>
          <div className={styles.insta}>
            {/* <div>
              {I18n.t('static.index.instagram')}
            </div>
            <a target="_blank" href={instagram} rel="noopener noreferrer">Golovina.brand</a> */}
          </div>
          <div className={styles.copy}>
            <div>© 2017 – {new Date().getFullYear()} {I18n.t('static.index.copy')}</div>
            <div>{I18n.t('static.index.made_by')} <a href="https://luckypike.com/" target="_blank" rel="noopener noreferrer">L..IKE</a></div>
          </div>
        </div>
      </div>
    </ErrorBoundary>
  )
}

Slide.propTypes = {
  slide: PropTypes.object,
  slideClassName: PropTypes.string
}

function Slide ({ slide, slideClassName }) {
  const videRef = useRef()

  useEffect(() => {
    if (videRef.current) {
      if (videRef.current.paused) {
        videRef.current.play()
      }
    }
  }, [])

  const handleClick = e => {
    if (videRef.current && videRef.current.paused) {
      videRef.current.play()
      e.preventDefault()
    }
  }

  return (
    <a
      href={slide.link_relative}
      className={classNames(slideClassName, { [styles.slideVideo]: slide.video_mp4 })}
      onClick={handleClick}
      style={{ backgroundImage: (slide.image && !slide.video_mp4 ? `url(${slide.image})` : null) }}
    >
      {slide.video_mp4 &&
        <video ref={videRef} className={styles.video} loop playsInline autoPlay muted preload="metadata">
          <source src={`https://golovina.store/video/${slide.video_mp4.key}.mp4`} type="video/mp4" />
        </video>
      }
      <div className={styles.text}>
        <div className={styles.title}>
          {slide.name}
        </div>

        {slide.desc &&
          <div className={styles.desc}>
            {slide.desc}
          </div>
        }
      </div>
    </a>
  )
}
