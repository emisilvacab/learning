import { module, test } from 'qunit';
import { setupRenderingTest } from 'rarwe/tests/helpers';
import { render } from '@ember/test-helpers';
import { hbs } from 'ember-cli-htmlbars';

module('Integration | Component | band-list', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    // Set any properties with this.set('myProperty', 'value');
    // Handle any actions with this.set('myAction', function(val) { ... });

    let banda = {
      id: 1,
      name: 'Lala',
      songs: [],
      description: 'asd',
    };
    let service = this.owner.lookup('service:router');
    service.isActive = () => true;
    this.set('testBands', [banda]);
    await render(hbs`<BandList @bands={{this.testBands}} />`);
    assert.dom(this.element).hasText('Lala');
  });
});
