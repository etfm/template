'use strict'

const vue3Template = require('..')
const assert = require('assert').strict

assert.strictEqual(vue3Template(), 'Hello from vue3Template')
console.info('vue3Template tests passed')
