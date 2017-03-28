{CompositeDisposable} = require 'atom'
md5 = require('blueimp-md5').md5

module.exports =
  config:
    imageUrls:
      description: 'Array of image url.'
      type: 'array'
      default: ["http://31.media.tumblr.com/058e722ce1dc63c3cc9833837ceb43a0/tumblr_nq2vpiAbUR1tfp3xbo1_500.gif","http://38.media.tumblr.com/e2460d38d5a8b0df3ea3ce2a99c1ebad/tumblr_nq2vo0OE6b1tfp3xbo1_500.gif","http://38.media.tumblr.com/c44f35c1ea44096f793f38956cc608f6/tumblr_nq2vmgYiNN1tfp3xbo1_400.gif","http://38.media.tumblr.com/645e2c022a969d0aa6252d21de5dfa9b/tumblr_nq2vkoFddz1tfp3xbo1_500.gif","http://38.media.tumblr.com/0b5223b3776747c5b8a5b4a60af91991/tumblr_nplgu8BQh91tfp3xbo1_500.gif","http://38.media.tumblr.com/5e6597bb566267410d225e75d54cfbc6/tumblr_np46xttt9g1tfp3xbo1_500.gif","http://38.media.tumblr.com/da39f2bcd60f4d3719b4047c9b711041/tumblr_nefflrC1cm1tfp3xbo1_400.gif","http://33.media.tumblr.com/0adff19abbc571f544bae4caaaef39f2/tumblr_n8rozxm2iS1tfp3xbo1_500.gif","http://38.media.tumblr.com/8d984253128f805fe7a7fbcd977100e0/tumblr_n8ro4e6gpw1tfp3xbo1_500.gif","http://38.media.tumblr.com/9f30ca169f5a1dd9fa25aadbdb0a5848/tumblr_n8ro5rYCTT1tfp3xbo1_1280.gif","http://33.media.tumblr.com/c6b9056d7224324a2548ea5bf596bce0/tumblr_n8ro2thMPq1tfp3xbo1_500.gif","http://38.media.tumblr.com/d288568c235f0cf0dad77265ba657db0/tumblr_n8ro205bYX1tfp3xbo1_1280.gif","http://38.media.tumblr.com/66a47c9c6e4681215b934e951d927e7a/tumblr_n8ro0tuzOo1tfp3xbo1_500.gif","http://38.media.tumblr.com/faa20279d722989daaffccaf58bb0145/tumblr_n8rnlwkkYn1tfp3xbo1_1280.gif","http://31.media.tumblr.com/750cf7f634b43f392a8812ab7019d294/tumblr_n8rme4vkJp1tfp3xbo1_500.gif","http://38.media.tumblr.com/6091bedb19294f46f75a902a0d7ba83e/tumblr_n8qgasjL2P1tfp3xbo1_400.gif","http://38.media.tumblr.com/1068f9a4c2e2a74a9b92beae1c11e14a/tumblr_n8qg8nwIsR1tfp3xbo1_400.gif","http://33.media.tumblr.com/436b1729407ab0ac017b24760f8baf1a/tumblr_n8omdkgcqq1tfp3xbo1_500.gif","http://38.media.tumblr.com/f1042f48459acd3b1e7c568c0faa7eec/tumblr_n8o30zwsJx1tfp3xbo1_500.gif","http://38.media.tumblr.com/e38dd7bcbdd9922e64ce2adb742f8b71/tumblr_n8obssKoaU1tfp3xbo1_500.gif","http://33.media.tumblr.com/ee8923667513d21a16db23aa79a9fc4a/tumblr_n8fygs1wII1tfp3xbo1_1280.gif","http://38.media.tumblr.com/e0ef277f81dbac1cc63ba58d375e0953/tumblr_n8ilteAgNu1tfp3xbo1_500.gif","http://33.media.tumblr.com/70b3cca34ceea024523b9bb1081fef91/tumblr_n8k5nmMjxx1tfp3xbo1_500.gif","http://31.media.tumblr.com/3e0e9ea707e089846ae3b5739c4ae6a1/tumblr_n8lo2oPe9k1tfp3xbo1_1280.gif","http://31.media.tumblr.com/96899afa6ea0907f30e80496bb43aab1/tumblr_n8lmco1Cmd1tfp3xbo1_500.gif","http://33.media.tumblr.com/3377dd3950e2c54553c23299ca07b9fc/tumblr_n8lpxtl7CB1tfp3xbo1_r1_250.gif","http://31.media.tumblr.com/9d2aa8e0636bafbddba822719df04089/tumblr_n8lr9muKPm1tfp3xbo1_500.gif","http://38.media.tumblr.com/092519e085277f547977e356f9231c1f/tumblr_n8nvp7EafO1tfp3xbo1_500.gif","http://38.media.tumblr.com/2b5ce88a2241ce3d7b755e5ca0f8c0d6/tumblr_n7vcdzlUqj1tfp3xbo1_1280.gif","http://38.media.tumblr.com/561f1783e625d04b553515eb2fe3c6da/tumblr_n7vcbu0zkU1tfp3xbo1_400.gif","http://33.media.tumblr.com/55145839fafefe236c014b5eb33c167d/tumblr_n7vc86xjuP1tfp3xbo1_1280.gif","http://33.media.tumblr.com/b7d9fe6211a563d59847a685c9bcc4d6/tumblr_n7mxqgRWX21tfp3xbo1_1280.gif","http://33.media.tumblr.com/b42d458050783f7c7a4c5f6cb8a140f0/tumblr_n7mx2uVLWJ1tfp3xbo1_1280.gif"]
      items:
        type: 'string'

  subscriptions: null

  activate: ->
    @srcs = atom.config.get('uniq-background.imageUrls')
    @subscriptions = new CompositeDisposable
    @subscriptions.add(atom.workspace.observeTextEditors((item) =>
      @addUniqBackground(item)
    ))

  addUniqBackground: (item) ->
    return unless item

    view = atom.views.getView(item)

    src = @srcForPath(item.getPath())
    image = document.createElement('img')
    image.className = 'uniq-image'
    image.src = src
    view.appendChild(image)

  srcForPath: (path)->
    number = parseInt(md5(path), 16)
    idx = number % @srcs.length
    @srcs[idx]
