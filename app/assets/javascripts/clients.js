var client = {
  edit: function(link) {
    var form = $(link).closest('form');
    form.find(':disabled').removeAttr('disabled');
    form.find('.extended-edit').show();
    $(link).hide();
  },

  add_contact : function(contact_info) {
    contact = this._add_association('contact', 'contacts', contact_info);
    contact.find('[name="client-name"]').text($('#client_name').val());
    contact.find('[name="client-local_name"]').text($('#client_local_name').val());
  },


  add_billing_address : function(billing_address_info) {
    billing_address = this._add_association('billing_address', 'billing_addresses', billing_address_info);
  },

  edit_contact : function(edit_el) {
    this._edit_association($(edit_el), 'contact');
  },
  edit_billing_address : function(edit_el) {
    this._edit_association($(edit_el), 'billing_address');
  },

  remove_contact: function(trash_el) {
    this._remove_association($(trash_el), 'contact', 'contacts');
  },
  remove_billing_address: function(trash_el) {
    this._remove_association($(trash_el), 'billing_address', 'billing_addresses');
  },
  _update_association: function(object, data, association, attributes_name) {
    var prefix = ['client[',attributes_name,'_attributes][]['].join('');
    for(var x in data) {
      var input_el = ["[name='",prefix,x,"]']"].join('');
      var label_el = ["[name='",x,"']"].join('');
      object.find(input_el).val(data[x]);
      object.find(label_el).text(data[x]);
    }
  },

  _add_association: function(association, target, association_info) {
    var form_selector = ['#add_',association,'_form'].join('');
    var card_style = [association, '-card'].join('');
    var target_selector = ['#',target].join('');
    var template = [association, '-card-template'].join('');
    var data = $(form_selector).data(association);

    if(typeof data == 'undefined') {
      data = $('.' + template).clone();
      data.removeClass(template);
      data.addClass(card_style);
      data.appendTo($(target_selector));
    }
    this._update_association(data, association_info, association, target);
    return data;
  },

  _edit_association: function(source, association) {
    var card_selector = ['.',association,'-card'].join('');
    var form_selector = ['#add_',association,'_form'].join('');
    var card = source.closest(card_selector);
    var inputs = $(form_selector + ' input');
    $.map(inputs, function(input, index) {
      input.value = card.find("[name='" + input.id + "']").text();
    });
    $(form_selector).data(association, card);
    var options = { model: association, 
      callback: function(data) { client['add_' + association](data); } };
      var association_form = new ModalEditForm(options);
      association_form.show();
  },
  _remove_association: function(source, association, attributes_name) {
    var card_selector = ['.',association,'-card'].join('');
    var association_id_selector = ['[name="client[',attributes_name,'_attributes][][id]"]'].join('');
    var destroy_input = ['<input type="hidden" name="client[',attributes_name,'_attributes][][_destroy]" value="1">'].join('');
    var destroy_style = [association,'-card-destroy'].join('');

    card = $(source).closest(card_selector);
    if(card.find(association_id_selector).length) {
      card.append(destroy_input);
      card.find('.icon-edit').parent().hide();
      card.find('.icon-trash').parent().hide();
      card.addClass('billing_address-card-destroy');
    } else {
      card.remove();
    }
  }
};
$(document).ready(function() {
  $('.btn.edit-contact').live('click', function() { client.edit_contact(this); });
  $('.btn.remove-contact').live('click', function() {client.remove_contact(this); });
  $('.btn.edit-billing_address').live('click', function() { client.edit_billing_address(this); });
  $('.btn.remove-billing_address').live('click', function() {client.remove_billing_address(this); });


  $('.form-edit-link').live('click', function() { client.edit(this); });
  $('#add_contact').click(function() {
    $('#add_contact_form').removeData('contact');
    var options = { model: 'contact', 
      callback: function(data) { client.add_contact(data); } };
    var contact_form = new ModalEditForm(options);
    contact_form.show();
  });
  $('#add_billing_address').click(function() {
    $('#add_billing_address_form').removeData('billing_address');
    var options = { model: 'billing_address', 
      callback: function(data) { client.add_billing_address(data); } };
    var billing_address_form = new ModalEditForm(options);
    billing_address_form.show();
  });
});
