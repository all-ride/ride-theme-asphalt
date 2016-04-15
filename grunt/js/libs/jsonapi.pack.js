/**
 * @class HttpClient
 * @see http://blog.garstasio.com/you-dont-need-jquery/ajax/
 */

/**
 * @method constructor
 * @param {string} url Base URL for the API
 */
function HttpClient() {
}

HttpClient.prototype.createRequest = function(method, url, headers, body) {
    return {
        'method': method,
        'url': url,
        'headers': headers,
        'body': body
    };
};

HttpClient.prototype.encodeParameters = function(object) {
    var encodedString = '';

    for (var prop in object) {
        if (object.hasOwnProperty(prop)) {
            if (encodedString.length > 0) {
                encodedString += '&';
            }

            encodedString += encodeURI(prop + '=' + object[prop]);
        }
    }

    return encodedString;
};

HttpClient.prototype.sendRequest = function(request) {
    request.method = request.method || 'GET';
    request.headers = request.headers || {};

    var xhr = new XMLHttpRequest();
    xhr.open(request.method, request.url, true);
    xhr.setRequestHeader('Content-Type', 'application/vnd.api+json');

    for (var prop in request.headers) {
        if (request.headers.hasOwnProperty(prop)) {
            xhr.setRequestHeader(prop, request.headers[prop]);
        }
    }

    if (request.onload) {
        xhr.onload = function() {
            request.onload(xhr);
        };
    } else if (request.onsuccess || request.onerror) {
        request.onsuccess = request.onsuccess || function() {};
        request.onerror = request.onerror || function() {};

        xhr.onload = function() {
            if (xhr.status >= 200 && xhr.status < 300) {
                request.onsuccess(xhr.responseText, xhr.status, xhr);
            } else {
                request.onerror(xhr.responseText, xhr.status, xhr);
            }
        };
    }

    if (!request.headers['Accept-Language']) {
        xhr.setRequestHeader('Accept-Language', document.documentElement.lang);
    }

    if (request.body) {
        if (typeof(request.body) == 'string') {
            body = request.body;
        } else {
            body = JSON.stringify(request.body);
        }

        xhr.send(body);
    } else {
        xhr.send();
    }

    return xhr;
};

HttpClient.prototype.get = function(url, headers, callback) {
    var request = this.createRequest('GET', url, headers);
    request.async = false;

    xhr = this.sendRequest(request);
};

/**
 * @class JsonApiDataStoreModel
 */
/**
 * @method constructor
 * @param {string} type The type of the model.
 * @param {string} id The id of the model.
 */
function JsonApiDataStoreModel(type, id) {
  this.id = id;
  this._type = type;
  this._attributes = [];
  this._relationships = [];
  this._meta = [];
}

/**
 * Serialize a model.
 * @method serialize
 * @param {object} opts The options for serialization.  Available properties:
 *
 *  - `{array=}` `attributes` The list of attributes to be serialized (default: all attributes).
 *  - `{array=}` `relationships` The list of relationships to be serialized (default: all relationships).
 * @return {object} JSONAPI-compliant object
 */
JsonApiDataStoreModel.prototype.serialize = function(opts) {
  var self = this,
      res = { data: { type: this._type } },
      key;

  opts = opts || {};
  opts.attributes = opts.attributes || this._attributes;
  opts.relationships = opts.relationships || this._relationships;

  if (this.id !== undefined) res.data.id = this.id;
  if (opts.attributes.length !== 0) res.data.attributes = {};
  if (opts.relationships.length !== 0) res.data.relationships = {};
  if (opts.meta !== undefined) res.data.meta = opts.meta;

  opts.attributes.forEach(function(key) {
    res.data.attributes[key] = self[key];
  });

  opts.relationships.forEach(function(key) {
    function relationshipIdentifier(model) {
      return { type: model._type, id: model.id };
    }
    if (self[key].constructor === Array) {
      res.data.relationships[key] = {
        data: self[key].map(relationshipIdentifier)
      };
    } else {
      res.data.relationships[key] = {
        data: relationshipIdentifier(self[key])
      };
    }
  });

  return res;
};

/**
 * Set/add an attribute to a model.
 * @method setAttribute
 * @param {string} attrName The name of the attribute.
 * @param {object} value The value of the attribute.
 */
JsonApiDataStoreModel.prototype.setAttribute = function(attrName, value) {
  if (this[attrName] === undefined) this._attributes.push(attrName);
  this[attrName] = value;
};

/**
 * Set/add a relationships to a model.
 * @method setRelationship
 * @param {string} relName The name of the relationship.
 * @param {object} models The linked model(s).
 */
JsonApiDataStoreModel.prototype.setRelationship = function(relName, models) {
  if (this[relName] === undefined) this._relationships.push(relName);
  this[relName] = models;
};

/**
 * @class JsonApiDataStore
 */
/**
 * @method constructor
 */
function JsonApiDataStore() {
  this.graph = {};
}

/**
 * Remove a model from the store.
 * @method destroy
 * @param {object} model The model to destroy.
 */
JsonApiDataStore.prototype.destroy = function(model) {
  delete this.graph[model._type][model.id];
};

/**
 * Retrieve a model by type and id. Constant-time lookup.
 * @method find
 * @param {string} type The type of the model.
 * @param {string} id The id of the model.
 * @return {object} The corresponding model if present, and null otherwise.
 */
JsonApiDataStore.prototype.find = function(type, id) {
  if (!this.graph[type] || !this.graph[type][id]) return null;
  return this.graph[type][id];
};

/**
 * Retrieve all models by type.
 * @method findAll
 * @param {string} type The type of the model.
 * @return {object} Array of the corresponding model if present, and empty array otherwise.
 */
JsonApiDataStore.prototype.findAll = function(type) {
  var self = this;

  if (!this.graph[type]) return [];
  return Object.keys(self.graph[type]).map(function(v) { return self.graph[type][v]; });
};

/**
 * Empty the store.
 * @method reset
 */
JsonApiDataStore.prototype.reset = function() {
  this.graph = {};
};

JsonApiDataStore.prototype.initModel = function(type, id) {
  this.graph[type] = this.graph[type] || {};
  this.graph[type][id] = this.graph[type][id] || new JsonApiDataStoreModel(type, id);

  return this.graph[type][id];
};

JsonApiDataStore.prototype.syncRecord = function(rec) {
  var self = this,
      model = this.initModel(rec.type, rec.id),
      key;

  function findOrInit(resource) {
    if (!self.find(resource.type, resource.id)) {
      var placeHolderModel = self.initModel(resource.type, resource.id);
      placeHolderModel._placeHolder = true;
    }
    return self.graph[resource.type][resource.id];
  }

  delete model._placeHolder;

  for (key in rec.attributes) {
    model._attributes.push(key);
    model[key] = rec.attributes[key];
  }

  if (rec.relationships) {
    for (key in rec.relationships) {
      var rel = rec.relationships[key];
      if (rel.data !== undefined) {
        model._relationships.push(key);
        if (rel.data === null) {
          model[key] = null;
        } else if (rel.data.constructor === Array) {
          model[key] = rel.data.map(findOrInit);
        } else {
          model[key] = findOrInit(rel.data);
        }
      }
      if (rel.links) {
        // console.log("Warning: Links not implemented yet.");
      }
    }
  }

  if (rec.meta) {
    model._meta = rec.meta;
  }

  return model;
};

/**
 * Sync a JSONAPI-compliant payload with the store.
 * @method sync
 * @param {object} data The JSONAPI payload
 * @return {object} The model/array of models corresponding to the payload's primary resource(s).
 */
JsonApiDataStore.prototype.sync = function(data) {
  var primary = data.data,
      syncRecord = this.syncRecord.bind(this);
  if (!primary) return [];
  if (data.included) data.included.map(syncRecord);
  return (primary.constructor === Array) ? primary.map(syncRecord) : syncRecord(primary);
};

/**
 * @class JsonApiClient
 */

/**
 * @method constructor
 * @param {string} url Base URL for the API
 */
function JsonApiClient(url) {
    this.url = url;
    this.client = new HttpClient();
    this.store = new JsonApiDataStore();
}

JsonApiClient.prototype.find = function(type, id) {
    if (id) {
        return this.store.find(type, id);
    } else {
        return this.store.findAll(type);
    }
};

JsonApiClient.prototype.load = function(type, id, onsuccess, onerror) {
    var self = this;
    var url = this.url + '/' + type;
    if (id) {
        url += '/' + id;
    }

    this.sendRequest('GET', url, null, onsuccess, onerror);
};

JsonApiClient.prototype.loadRelationship = function(type, id, relationship, onsuccess, onerror) {
    var url = this.url + '/' + type + '/' + id + '/' + relationship;

    this.sendRequest('GET', url, null, onsuccess, onerror);
};

JsonApiClient.prototype.save = function(model, onsuccess, onerror) {
    model = model.serialize();

    if (!model.data && !model.data.type) {
        throw new Exception('Invalid data provided');
    }

    var method = 'POST';
    var url = this.url + '/' + model.data.type;
    if (model.data.id) {
        method = 'PATCH';
        url += '/' + model.data.id;
    }

    this.sendRequest(method, url, model, onsuccess, onerror);
};

JsonApiClient.prototype.saveBulk = function(models, type, onsuccess, onerror) {
    var body = {'data': []};

    for (var index in models) {
      var model = models[index].serialize();
      if (!model.data || !model.data.type || model.data.type != type) {
          throw new Exception('Invalid data provided');
      }

      body.data.push(model.data);
    }

    var method = 'POST';
    var url = this.url + '/' + type;

    this.sendRequest(method, url, body, onsuccess, onerror);
};

JsonApiClient.prototype.sendRequest = function(method, url, body, onsuccess, onerror) {
    var self = this;

    var request = this.client.createRequest(method, url, {"Content-Type": "application/vnd.api+json"});
    request.type = 'json';
    if (body) {
        request.body = body;
    }

    request.onsuccess = function(data, status, xhr) {
        if (data) {
          data = self.store.sync(JSON.parse(data));
        }
        onsuccess(data);
    };
    request.onerror = onerror;

    this.client.sendRequest(request);
};
