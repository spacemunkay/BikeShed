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
              //needs to be called twice because?
              me.picker.alignTo(me.colorField.inputEl);
              me.picker.show();
              me.picker.alignTo(me.colorField.inputEl);
              me.picker.show();
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

/**
Ext.define('Ext.ux.ColorPickerCombo', {
	extend: 'Ext.form.field.Trigger',
	alias: 'widget.colorcbo',
    initComponent: function(){
      console.log("INIT");
      this.my_value = "pee";
      console.log(this.getValue);
      console.log(this.rawToValue(this.processRawValue(this.getRawValue())));
      console.log("hmmm");
    },
    getSubmitValue: function(){
      console.log("GETTING SUBMIT VALUE");
    },
    getSubmitData: function(){
      console.log("GETTING SUBMIT DATA VALUE");
    }
});
*/
/**
Ext.define('Ext.ux.ColorPickerCombo', {
	extend: 'Ext.form.field.Trigger',
    mixins: {
      field:'Ext.form.field.Field'
    },
	alias: 'widget.colorcbo',
	triggerTip: 'Please select a color.',
    picker: null,
    initComponent: function(){
      console.log("INIT");
	  var me = this;
      console.log(me);
	  me.picker = Ext.create('Ext.picker.Color', {
		renderTo: document.body,
		floating: true,
		hidden: false,
		style: {
          backgroundColor: "#fff"
        } ,
		listeners: {
          scope:this,
          select: function(field, value, opts){
            console.log(me.originalValue);
            console.log(value);
		    me.setValue(value);
		    me.setRawValue(value);
		    me.setFieldStyle("background-color:#"+value+";");
		    me.picker.hide();
            console.log("input el");
            console.log(me.inputEl);
            //$("#"+me.getInputId()).val(value);
            console.log("owner");
            console.log(me.picker.ownerCt);
            console.log(me.getValue());
            me.my_value = value;
            console.log("my_value");
            console.log(this.my_value);
            console.log(this.getValue);
    	  },
	      show: function(field,opts){
            console.log("show");
		    //field.getEl().monitorMouseLeave(500, field.hide, field);
		  }
        }
      });
      //me.picker.hide();
      console.log(me.picker.ownerCt);
    },
 	onTriggerClick: function() {
       var me = this;
       me.picker.alignTo(me.inputEl, 'tl-bl?');
       //me.picker.show(me.inputEl);
	},
    getValue: function(){
        console.log("GETTING VALUE");
        var me = this,
            val = me.rawToValue(me.processRawValue(me.getRawValue()));
        me.value = val;
        return val;
    }
});*/


/**
Ext.define('Ext.ux.ColorPickerCombo', {
	extend: 'Ext.form.field.Trigger',
	alias: 'widget.colorcbo',
	triggerTip: 'Please select a color.',
    myvalue: null,
    initComponent: function(){
      console.log("INIT");
      console.log(this);
    },
 	onTriggerClick: function() {
	  var me = this;
	  picker = Ext.create('Ext.picker.Color', {
		pickerField: this,
		ownerCt: this,
		renderTo: document.body,
		floating: true,
		hidden: true,
		focusOnShow: true,
		style: {
            	backgroundColor: "#fff"
        } ,
		listeners: {
          scope:this,
          select: function(field, value, opts){
		    me.setRawValue(value);
            me.resetOriginalValue(value);
            me.myvalue = value;
		    me.inputEl.setStyle({backgroundColor:value});
		    picker.hide();
            me.focus(true);
	      },
	      show: function(field,opts){
		    field.getEl().monitorMouseLeave(500, field.hide, field);
		  }
        }
      });
      picker.alignTo(me.inputEl, 'tl-bl?');
      picker.show(me.inputEl);
      picker.on('on', function(){
          var me = this;
          me.fireEvent('blur', me, e);
        }, me);
	},
    getValue: function(){
        console.log("GETTING VALUE");
        console.log(this.myvalue);
        console.log(this.inputEl.getValue());
        var me = this,
            val = this.myvalue || me.rawToValue(me.processRawValue(me.getRawValue()));
        me.value = val;
        return val;
    }
});*/
/**
Ext.define('Ext.ux.ColorPickerCombo', {
	extend: 'Ext.form.FieldContainer',
    mixins:{
      field:'Ext.form.field.Field'
    },
	alias: 'widget.colorcbo',

    //configurables
    combineErrors: true,
    msgTarget: 'under',
    layout: 'hbox',
    readOnly: false,

 	initComponent: function() {
	  var me = this;
      console.log(me);
	  me.picker = Ext.create('Ext.picker.Color', {
          pickerField: this,
          ownerCt: this,
          renderTo: document.body,
          floating: true,
          hidden: true,
          focusOnShow: true,
          style: {
            backgroundColor: "#fff"
          },
          listeners: {
            scope:this,
            select: function(field, value, opts){
              me.setValue(value);
              me.inputEl.setStyle({backgroundColor:value});
              me.picker.hide();
            },
            show: function(field,opts){
              field.getEl().monitorMouseLeave(500, field.hide, field);
            }
          }
      });
      me.callParent();
      //picker.alignTo(me.inputEl, 'tl-bl?');
      //picker.show(me.inputEl);
      // this dummy is necessary because Ext.Editor will not check whether an inputEl is present or not
      this.inputEl = {
          dom: document.createElement('div'),
          swallowEvent:function(){}
      };

      me.initField();
	},

    focus:function(){
        this.callParent(arguments);
        this.picker.focus();
    }
});*/
