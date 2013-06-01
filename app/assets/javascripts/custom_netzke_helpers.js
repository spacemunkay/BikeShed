//when signed out, or session expires forward to sign in page
Ext.Ajax.on('requestexception', function(conn, response, options) {
  if (response.status === 401) { window.location = '/users/sign_in'; }
}, this);

Ext.define('Ext.ux.form.field.ColorCombo', {
    extend:'Ext.form.FieldContainer',
    mixins:{
        field:'Ext.form.field.Field'
    },
    alias: 'widget.xcolorcombo',

    //configurables
    combineErrors: true,
    msgTarget: 'under',
    layout: 'hbox',
    readOnly: false,

    // properties
    colorValue: null,
    /**
     * @property dateField
     * @type Ext.form.field.Date
     */
    colorField: null,

    initComponent: function(){
        var me = this
            ,i = 0
            ,key
            ,tab;

        me.items = me.items || [];

        me.colorField = Ext.create('Ext.form.field.Trigger', {
            flex:1,
            isFormField:false, //exclude from field query's
            submitValue:false,
            readOnly: me.readOnly,
            onTriggerClick: function() {
              //show renders, so put first
              me.picker.show();
              me.picker.alignTo(me.colorField.inputEl);
            }
        });
        me.items.push(me.colorField);

        me.picker = Ext.create('Ext.picker.Color', {
          renderTo: document.body,
          floating: true,
          hidden: true,
          style: {
            backgroundColor: "#fff"
          },
          listeners: {
            scope:this,
            select: function(field, value, opts){
              me.setValue(value);
              me.picker.hide();
            }
          }
        });
        me.items.push(me.picker);

        for (; i < me.items.length; i++) {
            me.items[i].on('focus', Ext.bind(me.onItemFocus, me));
            me.items[i].on('blur', Ext.bind(me.onItemBlur, me));
            me.items[i].on('specialkey', function(field, event){
                key = event.getKey();
                tab = key == event.TAB;

                if (tab && me.focussedItem == me.dateField) {
                    event.stopEvent();
                    me.timeField.focus();
                    return;
                }

                me.fireEvent('specialkey', field, event);
            });
        }

        me.callParent();

        // this dummy is necessary because Ext.Editor will not check whether an inputEl is present or not
        this.inputEl = {
            dom: document.createElement('div'),
            swallowEvent:function(){}
        };

        me.initField();
    },
    focus:function(){
        this.callParent(arguments);
        this.colorField.focus();
        var me = this;
    },

    onItemFocus:function(item){
        if (this.blurTask){
            this.blurTask.cancel();
        }
        this.focussedItem = item;
    },

    onItemBlur:function(item, e){
        var me = this;
        if (item != me.focussedItem){ return; }
        // 100ms to focus a new item that belongs to us, otherwise we will assume the user left the field
        me.blurTask = new Ext.util.DelayedTask(function(){
            me.picker.hide();
            me.fireEvent('blur', me, e);
        });
        me.blurTask.delay(100);
    },

    getValue: function(){
        var value = null
            ,color = this.colorField.getSubmitValue();

        if (color){
          value = this.colorField.getValue();
        }
        return value;
    },

    getSubmitValue: function(){
//        var value = this.getValue();
//        return value ? Ext.Date.format(value, this.dateTimeFormat) : null;

        var me = this
            ,value = me.getValue();

        return value;
    },

    setValue: function(value){
        this.colorField.setValue(value);
    },
    // Bug? A field-mixin submits the data from getValue, not getSubmitValue
    getSubmitData: function(){
        var me = this
            ,data = null;

        if (!me.disabled && me.submitValue && !me.isFileUpload()) {
            data = {};
            data[me.getName()] = '' + me.getSubmitValue();
        }
        return data;
    }
});
