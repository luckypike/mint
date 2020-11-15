module.exports = {
  plugins: [
    require('postcss-flexbugs-fixes'),
    require('postcss-preset-env')({
      importFrom: [
        './app/javascript/css/custom-media.css',
        './app/javascript/css/variables.css'
      ],
      autoprefixer: {
        flexbox: 'no-2009'
      },
      features: {
        'custom-media-queries': true,
        'nesting-rules': true,
        'color-mod-function': { unresolved: 'warn' }
      }
    })
  ]
}
