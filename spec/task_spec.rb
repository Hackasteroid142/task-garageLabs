require 'rails_helper'

describe 'Task', type: :feature do
    context 'task page with no tasks' do
        it 'add task', js:true do
            visit root_path
            expect(page).to have_current_path(root_path)

            expect(page).to have_field('title')
            fill_in 'title', with: 'Prueba'
            click_button 'Enviar'
            expect(page).to have_current_path(root_path)
            expect(page).to have_content('Prueba')
        end
    end
    context 'task page with tasks' do
        before do
            visit root_path
            fill_in 'title', with: 'Prueba'
            click_button 'Enviar'
        end

        it 'delete task', js: true do
            expect(page).to have_current_path(root_path)
            expect(page).to have_selector(:link_or_button, 'Borrar')
            click_link_or_button 'Borrar'

            page.driver.browser.switch_to.alert.accept
            expect(page).not_to have_content('Prueba')
        end

        it 'confirm task', js: true do 
            expect(page).to have_current_path(root_path)
            expect(page).to have_selector(:link_or_button, 'Completar')
            click_link_or_button 'Completar'

            expect(page).to have_current_path(root_path)
            expect(page).to have_content('Prueba')
            expect(page).to have_css('li.data-task')
        end
    end
end