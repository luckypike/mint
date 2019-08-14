import React from 'react'

import page from '../Page'
import styles from './Service.module.css'

export default function Return () {
  return (
    <div className={page.root}>
      <div className={page.title}>
        <h1>Обмен и возврат</h1>
      </div>

      <div className={page.text}>
        <p>
          Возврат и обмен товара осуществляется в течение 7 дней с момента получения заказа, если он не был в употреблении,
          сохранен товарный вид, потребительские свойства, пломбы, фабричные ярлыки. В противном случае обмену и возврату товар не подлежит.
        </p>
        <p>
          Возврат и обмен товара по инициативе покупателя осуществляется за счет покупателя. Возврат и обмен товара при обнаружении производственного брака осуществляется за
          счет продавца. Возврат и обмен товара осуществляется транспортной компанией, в шоурумах по адресу: Москва, Большая Никитская, 21/18с4 или Нижний Новгород, Ошарская, 61.
        </p>
        <p>
          Для возврата денег Вам необходимо заполнить <a className={styles.link} href='/return_statement.docx'>акт возврата</a> и прислать нам на почту <a className={styles.link} href="mailto:shop@golovina.store">shop@golovina.store</a>. Возврат денежных средств осуществляется на банковскую карту в
          течение 10-ти рабочих дней с момента возвращения товара в магазин.
        </p>
      </div>
    </div>
  )
}
